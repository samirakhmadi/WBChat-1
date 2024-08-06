//
//  MessageView.swift
//  WBChat
//
//  Created by Александр on 05.08.2024.
//

import SwiftUI
import ExyteChat

struct MessageView: View {
    let message: Message
    let positionInUserGroup: PositionInUserGroup

    private var isCurrentUser: Bool {
        message.user.isCurrentUser
    }
    
    private var topPadding: CGFloat {
         positionInUserGroup == .single || positionInUserGroup == .first ? 12 : 6
    }

    private var bottomPadding: CGFloat {
        positionInUserGroup != .single && positionInUserGroup != .last ? 6 : 12
    }
    
    var body: some View {
        VStack(alignment: isCurrentUser ? .trailing : .leading, spacing: 4) {
            if let _ = message.replyMessage {
                Message_ReplyView(message: message, isCurrentUser: isCurrentUser)
                Message_PureTextView(message: message, isCurrentUser: isCurrentUser)
            }
            
            if !message.attachments.isEmpty {
                Message_AttachmentView(message: message)
                Message_PureTextView(message: message, isCurrentUser: isCurrentUser)
            }
            
            if message.text.isEmpty, let recording = message.recording {
                Message_WaveFormView(recording: recording)
                Message_DeliveryInfoView(message: message, isCurrentUser: isCurrentUser)
            }
            
            if message.replyMessage == nil && message.attachments.isEmpty && message.recording == nil {
                Message_PureTextView(message: message, isCurrentUser: isCurrentUser)
            }
        }
        .padding(10)
        .background(isCurrentUser ? .brand : .neutral)
        .messageShape(16, isCurrentUser: isCurrentUser)
        .padding(isCurrentUser ? .leading : .trailing, 77)
        .padding(.top, topPadding)
        .padding(.bottom, bottomPadding)
        .frame(maxWidth: .infinity, alignment: isCurrentUser ? .trailing : .leading)
        .padding(.horizontal)
    }
}

#Preview {
    VStack {
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
        ), positionInUserGroup: .first)
        .background(.yellow)
        
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
        ), positionInUserGroup: .middle)
        .background(.orange)
        
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
        ), positionInUserGroup: .middle)
        .background(.red)
        
        MessageView(message: Message(
            id: "18",
            user: User(
                id: "current_user",
                name: "Me",
                avatarURL: URL(string: "https://example.com/avatar.jpg"),
                isCurrentUser: false
            ),
            status: .read,
            createdAt: Date().addingTimeInterval(-86400),
            text: "Годзила топчик, позже запишу голосом"
        ), positionInUserGroup: .middle)
        .background(.brown)
        
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
        ), positionInUserGroup: .last)
        .background(.mint)
    }
}
