//
//  Message_AttachmentView.swift
//  WBChat
//
//  Created by Александр on 06.08.2024.
//

import SwiftUI
import ExyteChat

struct Message_AttachmentView: View {
    let message: Message
    
    var body: some View {
        VStack{
            ForEach(message.attachments) { attachment in
                AsyncImage(url: attachment.full, transaction: .init(animation: .easeInOut)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                    case .failure(_):
                        Image(systemName: "wifi.slash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                    default :
                        ProgressView()
                    }
                }
            }
        }
    }
}

#Preview {
    Message_AttachmentView(
        message: Message(
            id: "1",
            user:
                User(
                    id: "current_user",
                    name: "John",
                    avatarURL: URL(string: "https://example.com/john.jpg"),
                    isCurrentUser: false
                ),
            attachments: [
                .init(id: "godzilla", url: URL(string: "https://preview.redd.it/ai-godzilla-posters-v0-blqt0nximpub1.jpg?width=1024&format=pjpg&auto=webp&s=306ace41d9e9dd78ff285031118ceaa7b62234c0")!, type: .image)]
        ))
}

