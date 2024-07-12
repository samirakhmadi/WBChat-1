//
//  CustomSearchField.swift
//
//
//  Created by Александр on 11.07.2024.
//

import SwiftUI

public struct CustomSearchField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var placeholder: LocalizedStringKey
    var localizationTableName: String
    
    var textFieldBackgroundColor: Color
    var placeholderColor: Color
    let textColor: Color = .primary
    
    public init(
        text: Binding<String>,
        placeholder: LocalizedStringKey,
        localizationTableName: String,
        textFieldBackgroundColor: Color,
        placeholderColor: Color
    ) {
        self._text = text
        self.placeholder = placeholder
        self.localizationTableName = localizationTableName
        self.textFieldBackgroundColor = textFieldBackgroundColor
        self.placeholderColor = placeholderColor
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(placeholderColor)
            TextField("", text: $text)
                .foregroundColor(textColor)
                .focused($isFocused)
                .overlay(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder, tableName: localizationTableName)
                            .foregroundColor(placeholderColor)
                            .onTapGesture {
                                isFocused = true
                            }
                    }
                }
        }
        .font(.system(size: 14))
        .fontWeight(.semibold)
        .padding(.leading, 8)
        .frame(height: 36)
        .background(RoundedRectangle(cornerRadius: 4)
            .fill(textFieldBackgroundColor))
    }
}

#Preview {
    struct BindingViewPreviewContainer : View {
        @State private var text: String = ""
        
        var body: some View {
            CustomSearchField(
                text: $text,
                placeholder: "Placeholder",
                localizationTableName: "SomeTable",
                textFieldBackgroundColor: Color.gray.opacity(0.1),
                placeholderColor: .gray
            )
                .padding(.horizontal, 24)
        }
    }
    return BindingViewPreviewContainer()
}
