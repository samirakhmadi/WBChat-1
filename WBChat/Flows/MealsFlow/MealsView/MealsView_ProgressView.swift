//
//  MealsView_ProgressView.swift
//  WBChat
//
//  Created by Александр on 11.08.2024.
//

import SwiftUI
import UIComponents

struct MealsView_ProgressView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(3)
            .tint(.brand)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(ViewBackgroundColor(backgroundColor: .neutral))
    }
}

#Preview {
    MealsView_ProgressView()
}
