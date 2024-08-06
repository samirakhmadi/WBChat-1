//
//  Extension+View.swift
//  WBChat
//
//  Created by Александр on 03.07.2024.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

extension View {
    func messageShape(_ radius: CGFloat, isCurrentUser: Bool) -> some View {
        clipShape(MessageCorners(radius: radius, isCurrentUser: isCurrentUser))
    }
    
    func viewSize(_ size: CGFloat) -> some View {
        self.frame(width: size, height: size)
    }
}
