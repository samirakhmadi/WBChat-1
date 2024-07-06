//
//  TextBlockView.swift
//  WBChat
//
//  Created by Александр on 02.07.2024.
//

import SwiftUI

struct TextBlockView: View {
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey?
    
    var body: some View {
        VStack(alignment: .center, spacing: 8){
            Text(title, tableName: Localization.tableName)
                .foregroundStyle(.neutralText)
                .font(.system(size: 24).weight(.bold))
            
            switch subtitle {
            case .some(let subtitleText):
                Text(subtitleText, tableName: Localization.tableName)
                    .foregroundStyle(.neutralText)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .lineSpacing(10.0)
            case .none:
                EmptyView()
            }
        }
    }
}

#Preview {
    TextBlockView(
        title: Localization.inputPhoneText.rawValue,
        subtitle: Localization.inputPhoneDescriptionText.rawValue)
        .padding(.horizontal, 42)
}
