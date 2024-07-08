//
//  CodeVerificationView_CodeField.swift
//  WBChat
//
//  Created by Александр on 08.07.2024.
//

import SwiftUI

struct CodeVerificationView_CodeField: View {
    @FocusState.Binding var isFocused: Bool
    @Binding var verificationCode: String
    @State private var isAllNumbersFilled: Bool = false
    
    var pinLength = 4
    var onComplete: () -> ()
    
    var body: some View {
        TextField("", text: $verificationCode)
            .accentColor(.white)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .focused($isFocused)
            .padding()
            .onAppear {
                isFocused = true
            }
            .onChange(of: verificationCode) { _ in
                handleVerificationCodeChange()
            }
    }
}

private extension CodeVerificationView_CodeField {
    func handleVerificationCodeChange() {
        if verificationCode.count > pinLength {
            verificationCode = String(verificationCode.prefix(pinLength))
        }
        if verificationCode.count == pinLength && !isAllNumbersFilled {
            onComplete()
        } else if verificationCode.count < pinLength {
            isAllNumbersFilled = false
        }
    }
}

#Preview {
    struct CodeVerificationView_CodeField_PreviewContainer : View {
        @FocusState private var isFocused: Bool
        
        var body: some View {
            CodeVerificationView_CodeField(
                isFocused: $isFocused,
                verificationCode: .constant("1234")){}
                .padding(.horizontal)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        }
    }
    return CodeVerificationView_CodeField_PreviewContainer()
}
