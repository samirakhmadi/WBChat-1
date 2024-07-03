//
//  WBChatApp.swift
//  WBChat
//
//  Created by Александр on 05.06.2024.
//

import SwiftUI

@main
struct WBChatApp: App {

    @StateObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .environmentObject(router)
        }
    }
}
