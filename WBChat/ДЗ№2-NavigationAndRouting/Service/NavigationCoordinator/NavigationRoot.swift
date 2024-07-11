//
//  NavigationRoot.swift
//  WBChat
//
//  Created by Александр on 11.07.2024.
//

import SwiftUI

struct NavigationRoot<Content: View>: View {
    @ObservedObject var coordinator: NavigationCoordinator
    let content: Content

    init(coordinator: NavigationCoordinator, @ViewBuilder content: () -> Content) {
        self.coordinator = coordinator
        self.content = content()
    }

    var body: some View {
        NavigationView {
            NavigationStack(path: $coordinator.path) {
                content
                    .navigationDestination(for: Destination.self) { destination in
                        destination.view
                    }
            }
        }
    }
}
