//
//  NavigationCoordinator.swift
//  WBChat
//
//  Created by Александр on 11.07.2024.
//

import SwiftUI

class NavigationCoordinator: ObservableObject {
    @Published var path: [Destination] = []

    func navigate(to destination: Destination) {
        path.append(destination)
    }

    func pop() {
        _ = path.popLast()
    }
}
