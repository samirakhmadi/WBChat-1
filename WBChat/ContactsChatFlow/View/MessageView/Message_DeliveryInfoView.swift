//
//  Message_DeliveryInfoView.swift
//  WBChat
//
//  Created by Александр on 06.08.2024.
//

import SwiftUI
import ExyteChat

struct Message_DeliveryInfoView: View {
    let message: Message
    let isCurrentUser: Bool
    
    var body: some View {
        Group {
            if isCurrentUser {
                HStack(spacing: 0) {
                    Text(message.createdAt, format: .dateTime.hour().minute())
                    Message_StatusView(message: message)
                }
            } else {
                Text(message.createdAt, format: .dateTime.hour().minute())
                    .foregroundStyle(.senderDate)
            }
        }
        .font(.system(size: 10))
        .foregroundStyle(isCurrentUser ? .white  : .neutralText)
    }
}

#Preview {
    struct DeliveryInfoPreviewContainer : View {
        
        let readMessage: Message = .init(id: "1", user: .init(id: "", name: "", avatarURL: nil, isCurrentUser: true), status: .read)
        let sentMessage: Message =  .init(id: "1", user: .init(id: "", name: "", avatarURL: nil, isCurrentUser: true), status: .sent)
        
        var body: some View {
            VStack(spacing: 10) {
                Message_DeliveryInfoView(message: readMessage, isCurrentUser: true)
                Message_DeliveryInfoView(message: sentMessage, isCurrentUser: false)
            }
        }
    }
    return DeliveryInfoPreviewContainer()
}
