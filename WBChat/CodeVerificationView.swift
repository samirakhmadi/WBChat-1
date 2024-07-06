//
//  CodeVerificationView.swift
//  WBChat
//
//  Created by Александр on 06.07.2024.
//

import SwiftUI

struct CodeVerificationView: View {
    var body: some View {
        VStack {
            textBlock
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
        }
    }
}

private extension CodeVerificationView {
    var backButton: some View {
        NavigationBackButton()
    }
    
    var textBlock: some View {
        TextBlockView(
            title: Localization.codeEntry.rawValue,
            subtitle: Localization.codeEntryDescription.rawValue
        )
        .padding(.horizontal, 42)
        .padding(.top, 79)
    }
}

#Preview {
    NavigationStack {
        CodeVerificationView()
    }
}
