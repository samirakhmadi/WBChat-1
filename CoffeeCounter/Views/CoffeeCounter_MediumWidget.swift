//
//  CoffeeCounter_MediumWidget.swift
//  CoffeeCounterExtension
//
//  Created by Александр on 19.06.2024.
//

import SwiftUI
import WidgetKit

struct CoffeeCounter_MediumWidget: View {
    var entry: AmountInfoProvider.Entry
    var body: some View {
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


#Preview(as: .systemMedium) {
    CoffeeCounter()
} timeline: {
    CoffeeAmountEntry(date: .now, amount: 440)
    CoffeeAmountEntry(date: .now, amount: 500)
}
