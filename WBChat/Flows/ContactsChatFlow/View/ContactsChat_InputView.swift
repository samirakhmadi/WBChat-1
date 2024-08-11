//
//  ContactsChat_InputView.swift
//  WBChat
//
//  Created by Александр on 06.08.2024.
//

import SwiftUI
import ExyteChat

struct ContactsChat_InputView: View {
    @Binding var text: String
    let inputViewAction: (InputViewAction) -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                inputViewAction(.photo)
            }) {
                Image(systemName: "plus")
                    .fontWeight(.medium)
                    .viewSize(24)
            }
            .foregroundStyle(.gray)
            
            TextField("Сообщение...", text: $text)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.purple)
                .padding(.vertical, 6)
                .padding(.leading, 8)
                .background(RoundedRectangle(cornerRadius: 4).fill(.commonView))
            
            Button(action: {
                inputViewAction(.send)
            }) {
                Image(systemName: "paperplane.fill")
                    .viewSize(24)
            }
            .foregroundStyle(.brand)
        }
        .padding()
        .background(.neutral)
    }
}
#Preview {
    struct CustomInputViewPreviewContainer : View {
        @State private var messageText: String = ""
        
        var body: some View {
            ContactsChat_InputView(text: $messageText, inputViewAction: {_ in })
                .padding(.horizontal)
        }
    }
    return CustomInputViewPreviewContainer()
}
