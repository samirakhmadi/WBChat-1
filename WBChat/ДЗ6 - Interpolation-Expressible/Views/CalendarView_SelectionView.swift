//
//  CalendarView_SelectionView.swift
//  WBChat
//
//  Created by Александр on 21.06.2024.
//

import SwiftUI

struct CalendarView_SelectionView: View {
    
    @Binding  var selectedLocale: LocaleVariant
    @Binding  var selectedDate: Date

    var body: some View {
        HStack {
            Text(selectedLocale.flag)
                .font(.system(size: 150))
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.compact)
        }
        Picker("", selection: $selectedLocale.animation(.spring)) {
            ForEach(LocaleVariant.allCases) { locale in
                Text("\(locale.flag)")
                    .font(.title)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    CalendarView_SelectionView(selectedLocale: .constant(.russian), selectedDate: .constant(.now))
}
