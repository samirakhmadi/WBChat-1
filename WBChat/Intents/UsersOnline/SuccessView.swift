//
//  SuccessView.swift
//  WBChat
//
//  Created by Александр on 12.06.2024.
//

import SwiftUI

struct SuccessView: View {
    
    var text: String
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle")
                .foregroundStyle(.green)
                .imageScale(.large)
                .font(.largeTitle)
            Text("Онлайн \(text)")
        }
        .padding()
    }
}

#Preview {
    SuccessView(text: "17")
}
