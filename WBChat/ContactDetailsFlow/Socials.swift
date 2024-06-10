//
//  Socials.swift
//  WBChat
//
//  Created by Александр on 10.06.2024.
//

import SwiftUI

enum Socials: CaseIterable, Identifiable {
    case twitter, insta, linkedIn, facebook
    
    var id: Self { self }
    
    var icon: ImageResource {
        switch self {
        case .insta:
                .Socials.instagram
        case .twitter:
                .Socials.twitter
        case .linkedIn:
                .Socials.linkedin
        case .facebook:
                .Socials.facebook
        }
    }
}
