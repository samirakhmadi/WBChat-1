//
//  CodeVerificationView.swift
//  WBChat
//
//  Created by Александр on 06.07.2024.
//

import SwiftUI

struct CodeVerificationView: View {
    @Binding var verificationData: VerificationModel
    @FocusState private var isFocused: Bool
    @State private var enteredCode = ""

    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        VStack {
            textBlock
            codeView
            resendCodeButton
        }
        .padding()
        .navigationBarBackButtonHidden()
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
            Text(verificationData.phoneNumber)
                .font(.system(size: 14))
        }
        .padding(.horizontal, 42)
        .padding(.top, 79)
    }
    
    var codeView: some View {
        CodeVerificationView_CodeView(enteredCode: $enteredCode)
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
            enteredCode = ""
        }
    }
}

#Preview {
    NavigationStack {
        CodeVerificationView(verificationData: .constant(.init(phoneNumber: "77777777777")))
    }
}
