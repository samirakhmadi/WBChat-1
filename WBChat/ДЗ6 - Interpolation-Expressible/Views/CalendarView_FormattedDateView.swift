//
//  CalendarView_FormattedDateView.swift
//  WBChat
//
//  Created by Александр on 21.06.2024.
//

import SwiftUI

struct CalendarView_FormattedDateView: View {
    var dayLabels: [DayInfo]
    var selectedLocale: Locale
    var selectedDate: Date
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(dayLabels, id: \.date) { day in
                dateRow(title: day.title, date: day.date, locale: selectedLocale)
            }
        }
        .padding(.vertical, 5)
    }
}
private extension CalendarView_FormattedDateView {
    func dateRow(title: String, date: Date, locale: Locale) -> some View {
        HStack(spacing: 10) {
            Text(title)
            Spacer()
            if #available(iOS 17.0, *) {
                Text(date, format: .dateTime.weekday(.wide).day().month().year())
                    .environment(\.locale, .init(identifier: locale.identifier))
                    .contentTransition(.numericText())
            } else {
                Text(date, format: .dateTime.weekday(.wide).day().month().year())
                    .environment(\.locale, .init(identifier: locale.identifier))
            }
        }
        .font(selectedDate == date ? .body.italic().bold() : .body)
        .padding()
        .foregroundStyle(selectedDate == date ? .orange : .primary)
        .background(RoundedRectangle(cornerRadius: 12).stroke(selectedDate == date ? .red :.primary))
        .padding(.vertical, 5)
    }
}
