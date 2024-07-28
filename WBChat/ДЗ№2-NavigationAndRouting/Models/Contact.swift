//
//  Contact.swift
//  WBChat
//
//  Created by Александр on 07.06.2024.
//

import SwiftUI

struct Contact: Identifiable {
    var id = UUID()
    var name: String = ""
    var phoneNumber: String = ""
    var status: String = ""
    var isOnline: Bool = false
    var hasNewStories: Bool = false
    var avatar: ImageResource?
    var avatarURL: String
    
    init(
        name: String,
        phoneNumber: String,
        status: String,
        isOnline: Bool,
        hasNewStories: Bool,
        avatar: ImageResource? = nil
    ) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.status = status
        self.isOnline = isOnline
        self.hasNewStories = hasNewStories
        self.avatar = avatar
        self.avatarURL = "https://ui-avatars.com/api/?color=ffffff&background=000000&name=\(name.replacingOccurrences(of: " ", with: "+"))"
    }
}

extension Contact {
    static let contacts: [Contact] = [
        .init(
            name: "Анастасия Иванова",
            phoneNumber: "1111111111",
            status: "Last seen yesterday",
            isOnline: false,
            hasNewStories: false,
            avatar: .Avatars.nastya
        ),
        .init(
            name: "Петя",
            phoneNumber: "2222222222",
            status: "Online",
            isOnline: true,
            hasNewStories: false,
            avatar: .Avatars.petya
        ),
        .init(
            name: "Маман",
            phoneNumber: "3333333333",
            status: "Last seen 3 hours ago",
            isOnline: false,
            hasNewStories: true,
            avatar: .Avatars.maman
        ),
        .init(
            name: "Арбуз Дыня",
            phoneNumber: "4444444444",
            status: "Online",
            isOnline: true,
            hasNewStories: false,
            avatar: .Avatars.arbuz
        ),
        .init(
            name: "Иван Иванов",
            phoneNumber: "5555555555",
            status: "Online",
            isOnline: true,
            hasNewStories: false,
            avatar: nil
        ),
        .init(
            name: "Лиса Алиса",
            phoneNumber: "6666666666",
            status: "Last seen yesterday",
            isOnline: false,
            hasNewStories: true,
            avatar: nil
        ),
    ]
}

extension Contact: Hashable {}
