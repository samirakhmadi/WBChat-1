//
//  Tab.swift
//  WBChat
//
//  Created by Александр on 11.06.2024.
//

import Foundation

enum Tab: CaseIterable, Identifiable{
    case contacts, chats, more
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .contacts:
            "Контакты"
        case .chats:
            "Чаты"
        case .more:
            "Еще"
        }
    }
    
    var icon: ImageResource {
        switch self {
        case .contacts:
                .TabIcons.contacts
        case .chats:
                .TabIcons.chats
        case .more:
                .TabIcons.more
        }
    }
}
