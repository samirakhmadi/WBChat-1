//
//  CodeVerificationView.swift
//  WBChat
//
//  Created by Александр on 06.07.2024.
//

import SwiftUI

struct CodeVerificationView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    @Binding var verificationModel: VerificationModel
    @FocusState private var isFocused: Bool
    
    @State private var enteredCode = ""
    @State private var showHint: Bool = false
    @State private var showVerificationResult: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                textBlock
                codeView
                resendCodeButton
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(ViewBackgroundColor())
            verificationCodeHint
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
        }
        .onAppear {
            animateVerificationCode()
        }
        .onChange(of: isCodeFilled) { _ in
            showVerificationResult = verificationModel.validate(code: enteredCode)
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
            Text(verificationModel.phoneNumber)
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
            verificationModel.regenerateVerificationCode()
            resetPass()
            animateVerificationCode()
        }
        .foregroundStyle(.brand)
        .font(.system(size: 16).weight(.semibold))
        .padding(.top, 77)
    }
    
    var verificationCodeHint: some View {
        Group{
            Text("\(hintCode) ") + Text(Localization.accessCodeHint.rawValue, tableName: Localization.tableName)
        }
        .fontWeight(.semibold)
        .padding()
        .background(
            .thinMaterial,
            in: RoundedRectangle(cornerRadius: 25, style: .continuous)
        )
        .offset(y: showHint ? 0 : -250)
        .transition(.slide.combined(with: .move(edge: .top)))
    }
}

private extension CodeVerificationView {
    func resetPass() {
        withAnimation {
            enteredCode = ""
        }
    }
    
    func animateVerificationCode() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            withAnimation(.easeIn(duration: 1.5)) {
                showHint = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+6) {
                withAnimation(.easeOut(duration: 0.5)) {
                    showHint = false
                }
            }
        }
    }
}

private extension CodeVerificationView {
    var isCodeFilled: Bool {
        enteredCode.count == 4
    }
    
    var hintCode: String {
        verificationModel.map { String(describing: $0) }.joined()
    }
}

#Preview {
    struct CodeVerificationViewPreviewContainer : View {
        @State private var verificationData: VerificationModel = .init(phoneNumber: "77777777777777")
        
        var body: some View {
            NavigationStack {
                CodeVerificationView(verificationModel:  $verificationData)
            }
        }
    }
    return CodeVerificationViewPreviewContainer()
}
