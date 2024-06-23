//
//  CalendarView.swift
//  WBChat
//
//  Created by Александр on 20.06.2024.
//

import SwiftUI

//MARK: - View
struct CalendarView: View {
    
    @State private var selectedLocale: LocaleVariant = .russian
    @State private var selectedDate: Date = .now
    @State private var showInterpolationVariant: Bool = false

    
    private var dayLabels: [DayInfo] {
        let calendar = Calendar(identifier: .gregorian)
        let offsets = [-2, -1, 0, 1, 2]
        let titles = ["Позавчера", "Вчера", "Сегодня", "Завтра", "Послезавтра"]
        
        return zip(titles, offsets).compactMap { title, offset in
            calendar.date(byAdding: .day, value: offset, to: selectedDate).map { DayInfo(title: title, date: $0) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CalendarView_Header(showInterpolationVariant: $showInterpolationVariant)
            CalendarView_SelectionView(selectedLocale: $selectedLocale, selectedDate: $selectedDate)
            switch showInterpolationVariant {
            case true:
                CalendarView_InterpolatedDateView(
                    dayLabels: dayLabels,
                    selectedLocale: selectedLocale.locale,
                    selectedDate: selectedDate
                )
            case false:
                CalendarView_FormattedDateView(
                    dayLabels: dayLabels,
                    selectedLocale: selectedLocale.locale,
                    selectedDate: selectedDate
                )
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    CalendarView()
}
