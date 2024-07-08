//
//  CodeVerificationView_CodeView.swift
//  WBChat
//
//  Created by Александр on 08.07.2024.
//

import SwiftUI

struct CodeVerificationView_CodeView: View {
    @FocusState private var isFocused: Bool
    @Binding var verificationCode: String
    
    var pinLength = 4
    
    var body: some View {
        codeField
            .overlay {
                codeView
            }
    }
}

private extension CodeVerificationView_CodeView {
    var codeView: some View {
        HStack {
            ForEach(0..<pinLength, id: \.self) { index in
                Circle()
                    .fill(.neutralLine)
                    .frame(width: 24, height: 24)
                    .padding(.horizontal)
                    .overlay {
                        if verificationCode.count > index {
                            Text(getPin(at: index))
                                .font(.system(size: 32).bold())
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.neutralText)
                                .padding(.vertical, 1)
                        }
                    }
            }
        }
    }
    
    var codeField: some View {
        CodeVerificationView_CodeField(
            isFocused: $isFocused,
            verificationCode: $verificationCode)
    }
}

private extension CodeVerificationView_CodeView {
    func getPin(at index: Int) -> String {
        guard self.verificationCode.count > index else {
            return ""
        }
        return String(verificationCode[index])
    }
}


#Preview {
    struct CodeVerificationView_CodeView_PreviewContainer : View {
        @State private var verificationCode: String = "12"
        
        var body: some View {
            CodeVerificationView_CodeView(verificationCode: $verificationCode)
                .padding(.horizontal)
        }
    }
    return CodeVerificationView_CodeView_PreviewContainer()
}
