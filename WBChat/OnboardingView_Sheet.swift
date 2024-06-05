//
//  OnboardingView_Sheet.swift
//  WBChat
//
//  Created by Александр on 05.06.2024.
//

import SwiftUI

struct OnboardingView_Sheet: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            ViewBackgroundColor()
            VStack {
                Spacer()
                closeSheetButton
            }
        }
    }
}

private extension OnboardingView_Sheet {
    var closeSheetButton: some View {
        CapsuleButton(title: "Закрыть") {
            dismiss()
        }
        .padding(.top, 18)
        .padding(.bottom, 20)
        .padding(.horizontal, 24)
    }
}

#Preview {
    OnboardingView_Sheet()
}
