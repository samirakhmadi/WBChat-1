//
//  Country.swift
//  WBChat
//
//  Created by Александр on 03.07.2024.
//

import SwiftUI

enum Country: CaseIterable, Identifiable {
    case russia, kazakhstan, armenia
    
    var id: Self { self }
    
    var phoneCode: String {
        switch self {
        case .russia:
            "+7"
        case .kazakhstan:
            "+7"
        case .armenia:
            "+374"
        }
    }
    
    
    var flagIcon: ImageResource {
        switch self {
        case .russia:
                .Flags.ru32X32
        case .kazakhstan:
                .Flags.kz32X32
        case .armenia:
                .Flags.am32X32
        }
    }
}


