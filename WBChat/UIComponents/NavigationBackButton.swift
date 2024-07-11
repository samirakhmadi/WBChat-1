//
//  NavigationBackButton.swift
//  WBChat
//
//  Created by Александр on 02.07.2024.
//

import SwiftUI

struct NavigationBackButton: View {
    
    var action: () -> ()
    
    var body: some View {
        Button{
            action()
        } label: {
            Image(.backIcon)
                .resizable()
                .scaledToFit()
        }
        .frame(width: 24, height: 24, alignment: .trailing)
        .tint(.neutralText)
    }
}

#Preview {
    NavigationBackButton {}
}
