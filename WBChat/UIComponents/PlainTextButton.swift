//
//  PlainTextButton.swift
//  WBChat
//
//  Created by Александр on 03.07.2024.
//

import SwiftUI

struct PlainTextButton: View {
    var title: LocalizedStringKey
    var titleColor: Color
    var action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            Text(title, tableName: Localization.tableName)
                .foregroundStyle(titleColor)
                .font(.system(size: 14).weight(.semibold))
        }
    }
}

#Preview {
    PlainTextButton(title: Localization.userAgreementText.rawValue, titleColor: .brand) {}
}
