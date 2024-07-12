//
//  ViewBackgroundColor.swift
//  
//
//  Created by Александр on 11.07.2024.
//

import SwiftUI

public struct ViewBackgroundColor: View {
    var backgroundColor: Color
    
    public init(backgroundColor: Color) {
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        backgroundColor.ignoresSafeArea()
    }
}

#Preview {
    ViewBackgroundColor(backgroundColor: .cyan)
}
