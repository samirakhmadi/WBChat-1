//
//  CoffeeCounter_SmallWidget.swift
//  CoffeeCounterExtension
//
//  Created by Александр on 19.06.2024.
//

import SwiftUI
import WidgetKit

struct CoffeeCounter_SmallWidget: View {
    var entry: AmountInfoProvider.Entry
    var body: some View {
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
