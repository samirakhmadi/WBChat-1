//
//  NavigationBackButton.swift
//  
//
//  Created by Александр on 11.07.2024.
//

import SwiftUI

public struct NavigationBackButton: View {
    
    var image: String
    var tintColor: Color
    var action: () -> ()
    
    public init(
        image: String,
        tintColor: Color,
        action: @escaping () -> Void
    ) {
        self.image = image
        self.tintColor = tintColor
        self.action = action
    }
    
    public var body: some View {
        Button{
            action()
        } label: {
            Image(image)
                .resizable()
                .scaledToFit()
        }
        .frame(width: 24, height: 24, alignment: .trailing)
        .tint(tintColor)
    }
}

@available(iOS 17.0, *)
#Preview {
    NavigationBackButton(image: "", tintColor: .black) {}
}
