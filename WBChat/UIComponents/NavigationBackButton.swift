//
//  NavigationBackButton.swift
//  WBChat
//
//  Created by Александр on 02.07.2024.
//

import SwiftUI

struct NavigationBackButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button{
            dismiss()
        } label: {
            Image(.backIcon)
                .resizable()
                .scaledToFit()
        }
        .frame(width: 24, height: 24, alignment: .trailing)
        .tint(.neutralText)
    }
}

#Preview {
    NavigationBackButton()
}
