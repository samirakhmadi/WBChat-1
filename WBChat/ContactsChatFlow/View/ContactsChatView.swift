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
            MessageView(message: message, positionInUserGroup: positionInUserGroup)
        } inputViewBuilder: { text, attachments, inputViewState, inputViewStyle, inputViewActionClosure, dismissKeyboardClosure in
            ContactsChat_InputView(text: text, inputViewAction: inputViewActionClosure)
        } .headerBuilder { date in
            ContactsChat_DateHeaderView(date: date)
        }
        .chatTheme(colors: .init(mainBackground: .commonView))
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
               leadingToolbarStack
            }
            ToolbarItem(placement: .topBarTrailing) {
               trailingToolbarStack
            }
        }
        .toolbarBackground(.neutral, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

private extension ContactsChatView {
    
    var leadingToolbarStack: some View {
        HStack(spacing: 8) {
            backButton
            viewTitle
        }
    }
    
    var trailingToolbarStack: some View {
        HStack(spacing: 8) {
            searchButton
            menuButton
        }
    }
    
    var viewTitle: some View {
        Text(contact.name.trimmedSurname())
            .font(.system(size: 18, weight: .semibold))
    }
    
    var backButton: some View {
        ToolbarButton(
            image: "backIcon",
            tintColor: .neutralText) {}
            .padding(.leading, 6)
    }
    
    var searchButton: some View {
        ToolbarButton(
            image: "searchIcon",
            tintColor: .neutralText) {}
    }
    
    var menuButton: some View {
        ToolbarButton(
            image: "burgerIcon",
            tintColor: .neutralText) {}
            .padding(.trailing, 6)
    }
}

#Preview {
    NavigationStack {
        ContactsChatView(contact: .init(name: "Анастасия Иванова"))
    }
}
