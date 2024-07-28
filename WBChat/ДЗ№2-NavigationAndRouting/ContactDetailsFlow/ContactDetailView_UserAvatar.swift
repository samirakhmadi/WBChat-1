//
//  ContactDetailView_UserAvatar.swift
//  WBChat
//
//  Created by Александр on 10.06.2024.
//

import SwiftUI

struct ContactDetailView_UserAvatar: View {
    var contact: Contact
    var body: some View {
        switch contact.avatar {
        case .some(let avatar):
            contactImageView(avatar: avatar)
        case .none:
            contactInitialsView(contactName: contact.name)
        }
    }
}


//MARK: ImageView
private extension ContactDetailView_UserAvatar {
    func contactImageView(avatar: ImageResource) -> some View {
        Image(avatar)
            .resizable()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
    }
}

//MARK: InitialsView
private extension ContactDetailView_UserAvatar {
    func contactInitialsView(contactName: String) -> some View {
        Text(contactName.firstTwoInitials().uppercased())
            .font(.system(size: 100).weight(.medium))
            .foregroundStyle(.white)
            .frame(width: 200, height: 200)
            .background(.brand)
            .clipShape(Circle())
    }
}

#Preview {
    VStack{
        ContactDetailView_UserAvatar(
            contact: .init(
                name: "Иванов Иван",
                phoneNumber: "9999999999",
                status: "",
                isOnline: false,
                hasNewStories: false,
                avatar: .Avatars.petya
            )
        )
        ContactDetailView_UserAvatar(
            contact: .init(
                name: "Иванов Иван",
                phoneNumber: "9999999999",
                status: "",
                isOnline: true,
                hasNewStories: true
            )
        )
    }
}

