//
//  CodeVerificationView.swift
//  WBChat
//
//  Created by Александр on 06.07.2024.
//

import SwiftUI

struct CodeVerificationView: View {
    @Binding var phoneNumber: String
    
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
        VStack(spacing: 10) {
            TextBlockView(
                title: Localization.codeEntry.rawValue,
                subtitle: Localization.codeEntryDescription.rawValue
            )
            Text(phoneNumber)
                .font(.system(size: 14))
        }
        
        .padding(.horizontal, 42)
        .padding(.top, 79)
    }
}

#Preview {
    NavigationStack {
        CodeVerificationView(phoneNumber: .constant("79999999999".formatCustomNumber(mask: "+X XXX XXX-XX-XX")))
    }
}
