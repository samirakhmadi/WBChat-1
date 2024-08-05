//
//  MessageView.swift
//  WBChat
//
//  Created by Александр on 05.08.2024.
//

import SwiftUI
import ExyteChat

struct MessageView: View {
    var message: Message
    
    var body: some View {
        Text("Hello, World!")
    }
}


#Preview {
    VStack {
        Divider()
        MessageView(message: Message(
            id: "1",
            user:
                User(
                    id: "current_user",
                    name: "John",
                    avatarURL: URL(string: "https://example.com/john.jpg"),
                    isCurrentUser: false
                ),
            status: .read,
            createdAt: Date().addingTimeInterval(-86400),
            text: "Смотри че генерится :)",
            attachments: [.init(id: "godzilla", url: URL(string: "https://preview.redd.it/ai-godzilla-posters-v0-blqt0nximpub1.jpg?width=1024&format=pjpg&auto=webp&s=306ace41d9e9dd78ff285031118ceaa7b62234c0")!, type: .image)]
        ))
        Divider()
        MessageView(message: Message(
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
        ))
        Divider()
        MessageView(message: Message(
            id: "2",
            user: User(
                id: "current_user",
                name: "Me",
                avatarURL: URL(string: "https://example.com/avatar.jpg"),
                isCurrentUser: true
            ),
            status: .read,
            createdAt: Date().addingTimeInterval(-86400),
            text: "Годзила топчик, позже запишу голосом"
        ))
        Divider()
        MessageView(message: Message(
            id: "5",
            user: User(
                id: "other_user",
                name: "John",
                avatarURL: URL(string: "https://example.com/avatar.jpg"),
                isCurrentUser: true
            ),
            createdAt: Date().addingTimeInterval(1200),
            recording: .init(duration: 20, waveformSamples: [0.1, 0.3, 0.5, 0.8, 0.6, 0.4, 0.2, 0.7, 0.9, 0.5])
        ))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.chatBG)
}
