//
//  CodeVerificationView.swift
//  WBChat
//
//  Created by Александр on 06.07.2024.
//

import SwiftUI

struct CodeVerificationView: View {
    @Binding var phoneNumber: String
    @FocusState private var isFocused: Bool
    @State private var verificationCode = ""

    @EnvironmentObject var coordinator: NavigationCoordinator

    
    var body: some View {
        VStack {
            textBlock
            codeView
            resendCodeButton
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
        NavigationBackButton {
            coordinator.pop()
        }
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
    
    var codeView: some View {
        CodeVerificationView_CodeView(verificationCode: $verificationCode)
        .padding(.top, 49)
    }
    
    var resendCodeButton: some View {
        PlainTextButton(
            title: Localization.requestCodeAgain.rawValue,
            titleColor: .brand
        ) {
            resetPass()
        }
        .foregroundStyle(.brand)
        .font(.system(size: 16).weight(.semibold))
        .padding(.top, 77)
    }
}

private extension CodeVerificationView {
    func resetPass() {
        withAnimation {
            verificationCode = ""
        }
    }
}

#Preview {
    NavigationStack {
        CodeVerificationView(phoneNumber: .constant("79999999999".formatCustomNumber(mask: "+X XXX XXX-XX-XX")))
    }
}
