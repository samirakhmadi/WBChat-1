//
//  ContactsChatView.swift
//  WBChat
//
//  Created by Александр on 05.08.2024.
//

import SwiftUI
import ExyteChat
import UIComponents

struct ContactsChatView: View {
    var contact: Contact
    @State private var viewModel: ChatViewModel = .init()
    
    var body: some View {
        ChatView(messages: viewModel.messages, chatType: .conversation, replyMode: .answer) { draft in
            viewModel.sendMessage(draft: draft)
        } messageBuilder: { message, positionInUserGroup, positionInCommentsGroup, showContextMenu, messageAction, showAttachment in
            MessageView()
        }
        .chatTheme(colors: .init(mainBackground: .chatBG))
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack {
                    backButton
                    viewTitle
                }
            }
        }
        .toolbarBackground(.neutral, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

private extension ContactsChatView {
    var viewTitle: some View {
        Text(contact.name)
            .font(.system(size: 18, weight: .semibold))
    }
    
    var backButton: some View {
        NavigationBackButton(
            image: "backIcon",
            tintColor: .neutralText) {}
            .padding(.leading, 6)
    }
}

#Preview {
    NavigationStack {
        ContactsChatView(contact: .init(name: "Mock User"))
    }
}
