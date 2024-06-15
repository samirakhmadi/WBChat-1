//
//  CustomSearchField.swift
//  WBChat
//
//  Created by Александр on 15.06.2024.
//

import SwiftUI

struct CustomSearchField: View {
    @Binding var text: String
    var placeholder: String
    
    let placeholderColor: Color = .textFieldPlaceholder
    let textColor: Color = .primary
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(placeholderColor)
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(placeholderColor)
                }
                TextField("", text: $text)
                    .foregroundColor(textColor)
            }
        }
        .font(.system(size: 14))
        .fontWeight(.semibold)
        .padding(.leading, 8)
        .frame(height: 36)
        .background(RoundedRectangle(cornerRadius: 4)
            .fill(.textFieldBackground))
    }
}

#Preview {
    struct BindingViewPreviewContainer : View {
        @State private var text: String = ""
        
        var body: some View {
            ZStack{
                ViewBackgroundColor()
                CustomSearchField(text: $text, placeholder: "Search")
                    .padding(.horizontal, 24)
            }
            
        }
    }
    return BindingViewPreviewContainer()
}
