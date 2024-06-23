//
//  CalendarView_InterpolatedDateView.swift
//  WBChat
//
//  Created by Александр on 21.06.2024.
//

import SwiftUI

struct CalendarView_InterpolatedDateView: View {
    var dayLabels: [DayInfo]
    var selectedLocale: Locale
    var selectedDate: Date
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(dayLabels, id: \.date) { entry in
                interpolatedDateRow(title: entry.title, date: entry.date, locale: selectedLocale)
            }
        }
        .padding(.vertical, 5)
    }
}

private extension CalendarView_InterpolatedDateView {
    private func interpolatedDateRow(title: String, date: Date, locale: Locale) -> some View {
        HStack(spacing: 10) {
            Text(title)
            Spacer()
            if #available(iOS 17.0, *) {
                Text("\(spellOut: date, locale)")
                    .contentTransition(.numericText())
                    .frame(maxWidth: .infinity, alignment: .trailing)
            } else {
                Text("\(spellOut: date, locale)")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .font(selectedDate == date ? .body.italic().bold() : .body)
        .padding()
        .foregroundStyle(selectedDate == date ? .orange : .primary)
        .background(RoundedRectangle(cornerRadius: 12).stroke(selectedDate == date ? .red :.primary))
        .padding(.vertical, 5)
    }
}
