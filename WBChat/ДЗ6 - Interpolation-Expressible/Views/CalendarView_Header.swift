//
//  CalendarView_Header.swift
//  WBChat
//
//  Created by Александр on 21.06.2024.
//

import SwiftUI

struct CalendarView_Header: View {
    @Binding var showInterpolationVariant: Bool
    var body: some View {
        Toggle(isOn: $showInterpolationVariant.animation(.smooth), label: {
            Text("Решение через\n\(!showInterpolationVariant ? ".format: + environment(\\.locale)" :"appendInterpolation")")
                .font(.title3.bold())
                .multilineTextAlignment(.leading)
                .contentTransition(.opacity)
        })
    }
}

#Preview {
    struct BindingViewPreviewContainer : View {
        @State private var show: Bool = false
        
        var body: some View {
            CalendarView_Header(showInterpolationVariant: $show)
        }
    }
    return BindingViewPreviewContainer()
}
