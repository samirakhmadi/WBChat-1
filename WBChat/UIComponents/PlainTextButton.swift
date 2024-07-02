//
//  PlainTextButton.swift
//  WBChat
//
//  Created by Александр on 02.07.2024.
//

import SwiftUI

struct PlainTextButton: View {
    var title: LocalizedStringKey
    var action: () -> Void
    var body: some View {
        Button {} label: {
           Text(title, tableName: "AppLocalization")
                .foregroundStyle(.neutralText)
                .font(.system(size: 14).weight(.semibold))
                .environment(\.locale, Locale(identifier: "ru"))
        }
    }
}

#Preview {
    PlainTextButton(title: "userAgreementText", action: {})
}
