//
//  PlainTextButton.swift
//  
//
//  Created by Александр on 12.07.2024.
//

import SwiftUI

public struct PlainTextButton: View {
    var title: LocalizedStringKey
    var localizationTableName: String
    var titleColor: Color
    var action: () -> ()
    
    public init(
        title: LocalizedStringKey,
        localizationTableName: String,
        titleColor: Color,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.localizationTableName = localizationTableName
        self.titleColor = titleColor
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            Text(title, tableName: localizationTableName)
                .foregroundStyle(titleColor)
                .font(.system(size: 14).weight(.semibold))
        }
    }
}

#Preview {
    PlainTextButton(
        title: "Some Title",
        localizationTableName: "",
        titleColor: .purple
    ) {}
}
