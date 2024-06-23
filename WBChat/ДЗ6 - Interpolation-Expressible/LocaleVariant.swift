//
//  LocaleVariant.swift
//  WBChat
//
//  Created by Александр on 21.06.2024.
//

import Foundation

enum LocaleVariant: Identifiable, CaseIterable {
    
    var id: Self { self }
    
    case russian, english, spanish, japan, brazilian
    
    var flag: StringLiteralType {
        switch self {
        case .russian:
            "🇷🇺"
        case .english:
            "🇺🇸"
        case .spanish:
            "🇪🇸"
        case .japan:
            "🇯🇵"
        case .brazilian:
            "🇧🇷"
        }
    }
    
    var locale: Locale {
        switch self {
        case .russian:
            Locale(identifier: "ru")
        case .english:
            Locale(identifier: "en")
        case .spanish:
            Locale(identifier: "es")
        case .japan:
            Locale(identifier: "ja")
        case .brazilian:
            Locale(identifier: "pt")
        }
    }
}
