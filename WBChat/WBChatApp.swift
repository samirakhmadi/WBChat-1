//
//  WBChatApp.swift
//  WBChat
//
//  Created by Александр on 05.06.2024.
//

import SwiftUI

@main
struct WBChatApp: App {

    @StateObject private var coordinator = NavigationCoordinator()

    var body: some Scene {
        WindowGroup {
            MealsView(viewModel: MealsViewModel(client: MockClient()))
//            OnboardingView()
//                .environmentObject(coordinator)
        }
    }
}
