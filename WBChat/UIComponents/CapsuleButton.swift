//
//  CapsuleButton.swift
//  WBChat
//
//  Created by Александр on 05.06.2024.
//

import SwiftUI

struct CapsuleButton: View {
    var title: LocalizedStringKey
    var action: () -> Void
    var body: some View {
        Button { action() }
    label: {
        Text(title, tableName: "AppLocalization")
            .font(.system(size: 16).weight(.semibold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 98.5)
            .frame(height: 52)
            .background(
                Capsule()
                    .fill(.brand)
            )
            .foregroundStyle(.white)
    }
    }
}

#Preview {
    CapsuleButton(title: "startChattingText", action: {})
}
