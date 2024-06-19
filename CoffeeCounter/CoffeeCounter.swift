//
//  CoffeeCounter.swift
//  CoffeeCounter
//
//  Created by Александр on 18.06.2024.
//

import WidgetKit
import SwiftUI

struct AmountInfoProvider: TimelineProvider {
    func placeholder(in context: Context) -> CoffeeAmountEntry {
        CoffeeAmountEntry(
            date: Date(),
            amount: DataStorage.shared.loadCurrentCoffeeAmount()
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (CoffeeAmountEntry) -> ()) {
        let entry = CoffeeAmountEntry(
            date: Date(),
            amount: DataStorage.shared.loadCurrentCoffeeAmount()
        )
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [CoffeeAmountEntry] = []
        
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = CoffeeAmountEntry(
                date: entryDate,
                amount: DataStorage.shared.loadCurrentCoffeeAmount()
            )
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct CoffeeAmountEntry: TimelineEntry {
    let date: Date
    let amount: Double
}

struct CoffeeCounterEntryView : View {
    var entry: AmountInfoProvider.Entry
    @State private var selectedSize: CoffeeSize = .small
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            CoffeeCounter_SmallWidget(entry: entry)
        case .systemMedium:
            CoffeeCounter_MediumWidget(entry: entry)
        default:
            CoffeeCounter_SmallWidget(entry: entry)
        }
    }
}

struct CoffeeCounter: Widget {
    let kind: String = "CoffeeCounter"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: AmountInfoProvider()) { entry in
            if #available(iOS 17.0, *) {
                CoffeeCounterEntryView(entry: entry)
                    .containerBackground(.brand, for: .widget)
            } else {
                CoffeeCounterEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    CoffeeCounter()
} timeline: {
    CoffeeAmountEntry(date: .now, amount: 440)
    CoffeeAmountEntry(date: .now, amount: 980)
    CoffeeAmountEntry(date: .now, amount: 1000)
    CoffeeAmountEntry(date: .now, amount: 1200)
    CoffeeAmountEntry(date: .now, amount: 2500)
}

#Preview(as: .systemMedium) {
    CoffeeCounter()
} timeline: {
    CoffeeAmountEntry(date: .now, amount: 440)
    CoffeeAmountEntry(date: .now, amount: 500)
}

