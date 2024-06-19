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
    
//    private func getAmount() -> Double {
//        let defaults = UserDefaults.standard
//        return defaults.double(forKey: "amount")
//    }
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
            systemSmallWidget
        case .systemMedium:
            systemMediumWidget
        default:
            systemSmallWidget
        }
    }
}

private extension CoffeeCounterEntryView {
    var systemSmallWidget: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(.coffeeCup)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                Text(entry.amount.formattedVolume)
                .contentTransition(.numericText())
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
            }
            HStack(spacing: 8){
                Button(intent: ResetCoffeeIntent()) {
                   Image(systemName: "gobackward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .fontWeight(.light)
                        .padding()
                        .background(Circle().stroke(.primary, lineWidth: 1))
                }
                Button(intent: IncreaseCoffeeIntent()) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .fontWeight(.light)
                        .padding()
                        .background(Circle().stroke(.primary, lineWidth: 1))
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            .tint(.primary)
        }
    }
    
    
    var systemMediumWidget: some View {
        VStack {
            Text("Сопоставимо по объему с:")
                .fontWeight(.semibold)
            HStack(alignment: .bottom, spacing: 2) {
                ForEach(CoffeeSize.allCases.indices, id: \.self) { idx in
                    let coffeeSize = CoffeeSize.allCases[idx]
                    HStack {
                        Rectangle()
                            .frame(width: 1)
                        VStack(spacing: 4) {
                            Text("\(coffeeSize.cupVolume, format: .number.precision(.fractionLength(0))) мл")
                            Image(coffeeSize.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                            Text("\(coffeeSize.cupName)")
                            Text(entry.amount / coffeeSize.cupVolume, format: .number.precision(.fractionLength(2)))
                                .font(.callout)
                                .contentTransition(.numericText())
                        }
                        .frame(maxWidth: .infinity)
                        .containerRelativeFrame(.vertical) { length, _ in
                            length - 32
                        }
                        Rectangle()
                            .frame(width: 1)
                            .opacity(CoffeeSize.allCases.count - 1 != idx ? 0: 1)
                    }
                }
            }
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

