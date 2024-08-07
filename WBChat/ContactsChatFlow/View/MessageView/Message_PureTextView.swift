//
//  Message_PureTextView.swift
//  WBChat
//
//  Created by Александр on 06.08.2024.
//

import SwiftUI
import ExyteChat

struct Message_PureTextView: View {
    let message: Message
    let isCurrentUser: Bool
    
    var body: some View {
        VStack(
            alignment: isCurrentUser ? .trailing : .leading,
            spacing: 4
        ) {
            Text(message.text)
            Message_DeliveryInfoView(message: message, isCurrentUser: isCurrentUser)
        }
        .foregroundStyle(isCurrentUser ? .white : .neutralText)
    }
}

#Preview {
    struct TextViewPreviewContainer : View {
        var message: Message = .init(
            id: "3",
            user: User(
                id: "other_user",
                name: "John",
                avatarURL: URL(string: "https://example.com/john.jpg"),
                isCurrentUser: false
            ),
            text: "Кайфы, как тебе?",
            replyMessage: Message(
                id: "1",
                user:
                    User(
                        id: "other_user",
                        name: "John",
                        avatarURL: URL(string: "https://example.com/john.jpg"),
                        isCurrentUser: false
                    ),
                createdAt: Date().addingTimeInterval(-86400),
                text: "Купил годзиллу"
            ).toReplyMessage()
        )
        
        var body: some View {
            VStack(spacing: 20) {
                Message_PureTextView(message: message, isCurrentUser: true)
                Message_PureTextView(message: message, isCurrentUser: false)
            }
            .padding()
            .background(.red)
        }
    }
    return TextViewPreviewContainer()
}
