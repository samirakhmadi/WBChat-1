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

    var body: some View {
        TextField("", text: $verificationCode)
            .frame(width: 0, height: 0)
            .accentColor(.neutral)
            .foregroundColor(.neutral)
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
        
        isAllNumbersFilled = (verificationCode.count == pinLength)
        
    }
}

#Preview {
    struct CodeVerificationView_CodeField_PreviewContainer : View {
        @FocusState private var isFocused: Bool
        
        var body: some View {
            CodeVerificationView_CodeField(
                isFocused: $isFocused,
                verificationCode: .constant("1234"))
                .padding(.horizontal)
                .border(.primary, width: 1)
        }
    }
    return CodeVerificationView_CodeField_PreviewContainer()
}
