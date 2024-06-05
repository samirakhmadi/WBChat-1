//
//  CapsuleButton.swift
//  WBChat
//
//  Created by Александр on 05.06.2024.
//

import SwiftUI

struct CapsuleButton: View {
    var title: String
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .padding(.horizontal, 98.5)
                .background(
                    Capsule()
                        .fill(.brand)
                )
                .foregroundStyle(.white)
                .font(.system(size: 16).weight(.semibold))
        })
    }
}

#Preview {
    CapsuleButton(title: "Начать общаться", action: {})
}
