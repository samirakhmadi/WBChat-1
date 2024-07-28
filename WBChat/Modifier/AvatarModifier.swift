//
//  AvatarModifier.swift
//  WBChat
//
//  Created by Александр on 28.07.2024.
//

import SwiftUI

struct AvatarModifier: ViewModifier {
    var startGradientColor: Color
    var endGradientColor: Color
    var hasNewStories: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .frame(width: 48, height: 48)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(width: 56, height: 56)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(LinearGradient(
                        colors: [
                            startGradientColor,
                            endGradientColor
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),style: .init(lineWidth: 2))
                    .opacity(hasNewStories ? 1 : 0)
            )
    }
}

extension View {
    func modifiedAvatar(startGradientColor: Color, endGradientColor: Color, hasNewStories: Bool) -> some View {
        modifier(AvatarModifier(startGradientColor: startGradientColor, endGradientColor: endGradientColor, hasNewStories: hasNewStories))
    }
}
