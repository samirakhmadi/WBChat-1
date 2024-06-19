//
//  CoffeeSize.swift
//  WBChat
//
//  Created by Александр on 18.06.2024.
//

import SwiftUI

enum CoffeeSize: CaseIterable, Identifiable {
    var id: Self { self }
    case small, medium, large, xLarge
    
    var cupVolume: Double {
        switch self {
        case .small:
            200
        case .medium:
            300
        case .large:
            400
        case .xLarge:
            600
        }
    }
    
    var cupName: String {
         switch self {
         case .small:
             "Small"
         case .medium:
             "Medium"
         case .large:
             "Large"
         case .xLarge:
             "xLarge"
         }
     }
    
    var image: ImageResource {
        switch self {
        case .small:
                .smallCup
        case .medium:
                .mediumCup
        case .large:
                .coffeeCup
        case .xLarge:
                .coffeeCup
        }
    }
 }
