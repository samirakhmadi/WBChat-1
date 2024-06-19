//
//  ContactsView_ContactRow.swift
//  WBChat
//
//  Created by Александр on 07.06.2024.
//

import SwiftUI

struct ContactsView_ContactRow: View {
    let contact: Contact
    let isNeedTopPadding: Bool
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                ZStack(alignment: .topTrailing){
                    userAvatar
                    statusCircle
                }
                userInfo
                Spacer()
            }
            .padding(.top, isNeedTopPadding ? 12 : 0)
            .padding(.bottom, 12)
            Rectangle()
                .fill(.neutralLine)
                .frame(height: 1)
        }
        .padding(.horizontal, 24)
    }
}

//MARK: Subviews
private extension ContactsView_ContactRow {
    var userAvatar: some View {
        ContactRow_UserAvatar(contact: contact)
    }
    
    var userInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(contact.name)
                .font(.system(size: 14).weight(.semibold))
                .foregroundStyle(.neutralText)
                .frame(height: 24)
            Text(contact.status)
                .font(.system(size: 12).weight(.regular))
                .foregroundStyle(.neutralDisabled)
                .frame(height: 20)
        }
    }
    
    var statusCircle: some View {
        Circle()
            .stroke(.white, lineWidth: 2)
            .background(Circle().fill(.green))
            .frame(width: 12)
            .opacity(contact.isOnline ? 1 : 0)
    }
}

#Preview {
    struct BindingViewPreviewContainer : View {
        var contacts: [Contact] = [
            .init(
                name: "Анастасия Иванова",
                status: "Last seen yesterday",
                isOnline: false,
                hasNewStories: false,
                avatar: .Avatars.nastya
            ),
            .init(
                name: "Петя",
                status: "Онлайн",
                isOnline: true,
                hasNewStories: true,
                avatar: .Avatars.petya
            ),
            .init(
                name: "Анастасия Иванова",
                status: "Онлайн",
                isOnline: true,
                hasNewStories: true,
                avatar: nil
            ),
        ]
        var body: some View {
            VStack{
                ForEach(contacts) { contact in
                    ContactsView_ContactRow(contact: contact, isNeedTopPadding: true)
                }
            }
            .padding(.horizontal)
            .background(ViewBackgroundColor())
        }
    }
    return BindingViewPreviewContainer()
}
