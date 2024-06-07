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
    var status: String = ""
    var isOnline: Bool = false
    var hasNewStories: Bool = false
    var avatar: ImageResource? = nil
}

extension Contact {
    static let contacts: [Contact] = [
        .init(
            name: "Анастасия Иванова",
            status: "Last seen yesterday",
            isOnline: false,
            hasNewStories: false,
            avatar: .Avatars.nastya
        ),
        .init(
            name: "Петя",
            status: "Online",
            isOnline: true,
            hasNewStories: false,
            avatar: .Avatars.petya
        ),
        .init(
            name: "Маман",
            status: "Last seen 3 hours ago",
            isOnline: false,
            hasNewStories: true,
            avatar: .Avatars.maman
        ),
        .init(
            name: "Арбуз Дыня",
            status: "Last seen yesterday",
            isOnline: true,
            hasNewStories: false,
            avatar: .Avatars.arbuz
        ),
        .init(
            name: "Иван Иванов",
            status: "Last seen yesterday",
            isOnline: true,
            hasNewStories: false,
            avatar: nil
        ),
        .init(
            name: "Лиса Алиса",
            status: "Last seen yesterday",
            isOnline: false,
            hasNewStories: true,
            avatar: nil
        ),
    ]
}
