//
//  SettingsView.swift
//  WBChat
//
//  Created by Samir on 10.08.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            Text("⚙️ \("Settings".localized)")
                .font(.largeTitle)
                .padding()
        }
    }
}
