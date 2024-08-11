//
//  Message_ReplyView.swift
//  WBChat
//
//  Created by Александр on 06.08.2024.
//

import SwiftUI
import ExyteChat

struct Message_ReplyView: View {
    let message: Message
    let isCurrentUser: Bool
    
    var body: some View {
        VStack(alignment: isCurrentUser ? .trailing : .leading) {
            VStack(alignment: .leading, spacing: 4) {
                Text(isCurrentUser ? message.user.name : "Вы")
                    .foregroundStyle(.replyAccent)
                    .font(.system(size: 10, weight: .semibold))
                Text(message.replyMessage?.text ?? "")
                    .foregroundStyle(.neutralText)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(.replyBG)
            .overlay(alignment: .leading) {
                Rectangle()
                    .frame(width: 4)
                    .foregroundStyle(.replyAccent)
            }
            .mask(RoundedRectangle(cornerRadius: 4))
        }
    }
}

#Preview {
    struct ReplyViewPreviewContainer : View {
        let message = Message(
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
            VStack(spacing: 10) {
                Message_ReplyView(message: message, isCurrentUser: true)
                Message_ReplyView(message: message, isCurrentUser: false)
            }
        }
    }
    return ReplyViewPreviewContainer()
}
