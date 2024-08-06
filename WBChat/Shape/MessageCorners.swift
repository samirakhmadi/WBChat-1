//
//  MessageCorners.swift
//  WBChat
//
//  Created by Александр on 06.08.2024.
//

import SwiftUI

struct MessageCorners: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    var isCurrentUser: Bool
    
    func path(in rect: CGRect) -> Path {
        let cornersToRound: UIRectCorner
        
        switch isCurrentUser {
        case true:
            cornersToRound = [.topLeft, .topRight, .bottomLeft]
        case false:
            cornersToRound = [.topLeft, .topRight, .bottomRight]
        }
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: cornersToRound, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    VStack(spacing: 10) {
        Rectangle()
            .fill(.red)
            .frame(width: 150, height: 150)
            .messageShape(16, isCurrentUser: false)
        
        Rectangle()
            .fill(.orange)
            .frame(width: 150, height: 150)
            .messageShape(16, isCurrentUser: true)
    }
}
