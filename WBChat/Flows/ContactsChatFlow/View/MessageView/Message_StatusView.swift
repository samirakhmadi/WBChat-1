//
//  Message_StatusView.swift
//  WBChat
//
//  Created by Александр on 06.08.2024.
//

import SwiftUI
import ExyteChat

struct Message_StatusView: View {
    
    let message: Message
    
    var body: some View {
        Group {
            switch message.status {
            case .read:
                Text("•Прочитано")
            case .sending:
                ProgressView()
                    .tint(.white)
                    .scaleEffect(0.6)
                    .frame(height: 10)
            case .sent:
                Image(systemName: "checkmark")
            case .error(_):
                Image(systemName: "exclamationmark.circle.fill")
                    .foregroundStyle(.red)
            default:
                EmptyView()
            }
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        Message_StatusView(message: .init(id: "1", user: .init(id: "", name: "", avatarURL: nil, isCurrentUser: true), status: .read))
        Message_StatusView(message: .init(id: "1", user: .init(id: "", name: "", avatarURL: nil, isCurrentUser: true), status: .sent))
        Message_StatusView(message: .init(id: "1", user: .init(id: "", name: "", avatarURL: nil, isCurrentUser: true), status: .sending))
    }
    .frame(width: 200, height: 200)
    .background(.green)
}
