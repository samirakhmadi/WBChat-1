//
//  TextBlockView.swift
//  WBChat
//
//  Created by Александр on 02.07.2024.
//

import SwiftUI

struct TextBlockView: View {
    var title: String
    var subtitle: String?
    
    var body: some View {
        VStack(alignment: .center, spacing: 8){
            Text(title)
                .foregroundStyle(.neutralText)
                .font(.system(size: 24).weight(.bold))
            if let subtitle {
                Text(subtitle)
                    .foregroundStyle(.neutralText)
                    .font(.system(size: 13))
                    .multilineTextAlignment(.center)
                    .lineSpacing(10.0)
            }
        }
    }
}

#Preview {
    TextBlockView(title: "Введите номер телефона", subtitle: "Мы вышлем код подтверждения на указаннный номер")
        .padding(.horizontal, 42)
}
