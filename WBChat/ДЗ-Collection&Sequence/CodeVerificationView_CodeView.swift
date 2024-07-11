//
//  CodeVerificationView_CodeView.swift
//  WBChat
//
//  Created by Александр on 08.07.2024.
//

import SwiftUI

struct CodeVerificationView_CodeView: View {
    @FocusState private var isFocused: Bool
    @Binding var enteredCode: String
    
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
                let isFilled = enteredCode.count > index
                codePlaceholder(isFilled: isFilled)
                    .overlay {
                        if isFilled { codeSymbol(index: index) }
                    }
            }
        }
    }
    
    var codeField: some View {
        CodeVerificationView_CodeField(
            isFocused: $isFocused,
            receivedCode: $enteredCode)
    }
}

private extension CodeVerificationView_CodeView {
    func codePlaceholder(isFilled: Bool) -> some View {
        Circle()
            .fill(.neutralLine)
            .frame(width: 24, height: 24)
            .padding(.horizontal)
            .opacity(isFilled ? 0 : 1)
            .animation(.easeInOut, value: isFilled)
    }
    
    func codeSymbol(index: Int) -> some View {
        Text(getPin(at: index))
            .font(.system(size: 32).bold())
            .frame(width: 24, height: 24)
            .foregroundStyle(.neutralText)
            .padding(.vertical, 1)
    }
}

private extension CodeVerificationView_CodeView {
    func getPin(at index: Int) -> String {
        guard self.enteredCode.count > index else {
            return ""
        }
        return String(enteredCode[index])
    }
}


#Preview {
    struct CodeVerificationView_CodeView_PreviewContainer : View {
        @State private var verificationCode: String = "12"
        
        var body: some View {
            CodeVerificationView_CodeView(enteredCode: $verificationCode)
                .padding(.horizontal)
        }
    }
    return CodeVerificationView_CodeView_PreviewContainer()
}
