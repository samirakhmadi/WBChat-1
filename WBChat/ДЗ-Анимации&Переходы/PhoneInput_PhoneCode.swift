//
//  PhoneInput_PhoneCode.swift
//  WBChat
//
//  Created by Александр on 02.07.2024.
//

import SwiftUI

struct PhoneInput_PhoneCode: View {
    
    var phoneCode: String
    @Binding var  phoneNumber: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(.Flags.ru32X32)
                .resizable()
                .frame(width: 16, height: 16)
            Text(phoneCode)
                .foregroundStyle(phoneNumber.isEmpty ? .neutralDisabled : .neutralText)
                .animation(.easeInOut, value: phoneNumber)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.textFieldBackground)
        )
    }
}

#Preview {
    struct PhoneInput_PhoneCodePreviewContainer : View {
        @State private var phoneNumber: String = ""
        
        var body: some View {
            PhoneInput_PhoneCode(phoneCode: "+7", phoneNumber: $phoneNumber)
                .padding(.horizontal)
        }
    }
    return PhoneInput_PhoneCodePreviewContainer()
}
