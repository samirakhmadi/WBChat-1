//
//  ContactRow_UserAvatar.swift
//  WBChat
//
//  Created by Александр on 07.06.2024.
//

import SwiftUI

struct ContactRow_UserAvatar: View {
    var contact: Contact
    
    var body: some View {
        if let avatar = contact.avatar {
            contactImageView(avatar: avatar, hasNewStories: contact.hasNewStories)
        } else {
            contactInitialsView(contactName: contact.name, hasNewStories: contact.hasNewStories)
        }
    }
}
//MARK: ImageView
private extension ContactRow_UserAvatar {
    func contactImageView(avatar: ImageResource, hasNewStories: Bool) -> some View {
        Image(avatar)
            .resizable()
            .frame(width: 48, height: 48)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(width: 56, height: 56)
            .background(
                RoundedRectangle(cornerRadius: 16)
                .stroke(LinearGradient(
                    colors: [
                        .GradientStyle1Colors.gradientLightBlue,
                        .GradientStyle1Colors.gradientBlue
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),style: .init(lineWidth: 2))
                .opacity(hasNewStories ? 1 : 0)
            )
    }
}

//MARK: InitialsView
private extension ContactRow_UserAvatar {
    func contactInitialsView(contactName: String, hasNewStories: Bool) -> some View {
        Text(contactName.firstTwoInitials().uppercased())
            .font(.system(size: 14).bold())
            .foregroundStyle(.white)
            .frame(width: 48, height: 48)
            .background(.brand)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(width: 56, height: 56)
            .background(
                RoundedRectangle(cornerRadius: 16)
                .stroke(LinearGradient(
                    colors: [
                        .GradientStyle2Colors.gradientPink,
                        .GradientStyle2Colors.gradientPurple
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),style: .init(lineWidth: 2))
                .opacity(hasNewStories ? 1 : 0)
            )
    }
}



#Preview {
    VStack {
        ContactRow_UserAvatar(contact: .init(
            name: "Анастасия Иванова",
            status: "Last seen yesterday",
            isOnline: false,
            hasNewStories: false,
            avatar: .Avatars.nastya
        ))
        .padding(.vertical, 16)
        ContactRow_UserAvatar(contact: .init(
            name: "Петя",
            status: "Онлайн",
            isOnline: true,
            hasNewStories: true,
            avatar: .Avatars.petya
        ))
        .padding(.vertical, 16)
        ContactRow_UserAvatar(contact: .init(
            name: "Анастасия Иванова",
            status: "Онлайн",
            isOnline: true,
            hasNewStories: true,
            avatar: nil
        ))
        .padding(.vertical, 16)
    }
}
