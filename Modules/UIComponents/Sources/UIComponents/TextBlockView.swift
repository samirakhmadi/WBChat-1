//
//  TextBlockView.swift
//  
//
//  Created by Александр on 11.07.2024.
//

import SwiftUI

public struct TextBlockView: View {
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey?
    
    var localizationTableName: String
    var textForegroundColor: Color
    
    public init(
        title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        localizationTableName: String,
        textForegroundColor: Color
    ) {
        self.title = title
        self.subtitle = subtitle
        self.localizationTableName = localizationTableName
        self.textForegroundColor = textForegroundColor
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 8){
            Text(title, tableName: localizationTableName)
                .foregroundStyle(textForegroundColor)
                .font(.system(size: 24).weight(.bold))
            
            switch subtitle {
            case .some(let subtitleText):
                Text(subtitleText, tableName: localizationTableName)
                    .foregroundStyle(textForegroundColor)
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
        title: "Some Title",
        subtitle: "Some Subtitle",
        localizationTableName: "",
        textForegroundColor: .primary
    )
        .padding(.horizontal, 42)
}
