//
//  ContactsView_ContactRow.swift
//  WBChat
//
//  Created by Александр on 07.06.2024.
//

import SwiftUI
import UIComponents

struct ContactsView_ContactRow: View {
    let contact: Contact
    let isNeedTopPadding: Bool
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                userAvatar(contact: contact)
                    .overlay(alignment: .topTrailing) {
                        statusCircle
                    }
                userInfo
            }
            .frame(maxWidth: .infinity, alignment: .leading)
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
    
    func userAvatar(contact: Contact) -> some View {
        ContactsRow_AsyncAvatar(url: contact.avatarURL)
            .modifiedAvatar(
                startGradientColor: contact.avatar == nil ? .GradientStyle2Colors.gradientPink : .GradientStyle1Colors.gradientLightBlue,
                endGradientColor: contact.avatar == nil ?
                    .GradientStyle2Colors.gradientPurple :
                    .GradientStyle1Colors.gradientBlue,
                hasNewStories: contact.hasNewStories
            )
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
                phoneNumber: "",
                status: "Last seen yesterday",
                isOnline: false,
                hasNewStories: false,
                avatar: .Avatars.nastya
            ),
            .init(
                name: "Петя",
                phoneNumber: "",
                status: "Онлайн",
                isOnline: true,
                hasNewStories: true,
                avatar: .Avatars.petya
            ),
            .init(
                name: "Анастасия Иванова",
                phoneNumber: "",
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
            .background(ViewBackgroundColor(backgroundColor: .neutral))
        }
    }
    return BindingViewPreviewContainer()
}
