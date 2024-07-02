//
//  CapsuleButton.swift
//  WBChat
//
//  Created by Александр on 05.06.2024.
//

import SwiftUI

struct CapsuleButton: View {
    var title: String
    var isDisabled: Bool = false
    var action: () -> Void
    var body: some View {
        Button { action() }
        label: {
        Text(title)
            .font(.system(size: 16).weight(.semibold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 98.5)
            .frame(height: 52)
            .background(
                Capsule()
                    .fill(isDisabled ? .brand.opacity(0.5) : .brand)
            )
            .foregroundStyle(.white)
        }.disabled(isDisabled)
    }
}

#Preview {
    CapsuleButton(title: "Начать общаться", action: {})
}
