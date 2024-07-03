//
//  PhoneInput_PhoneNumber.swift
//  WBChat
//
//  Created by Александр on 02.07.2024.
//

import SwiftUI

struct PhoneInput_PhoneNumber: View {
    @Binding var phoneNumber: String
    var body: some View {
        TextField("000 000-00-00", text: $phoneNumber)
            .foregroundStyle(.neutralText)
            .fontWeight(.semibold)
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
            .keyboardType(.numberPad)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.textFieldBackground)
            )
            .onChange(of: phoneNumber) { newValue in
                if !newValue.isEmpty {
                    phoneNumber = newValue.formatCustomNumber(mask: "XXX XXX-XX-XX")
                }
            }
    }
}

#Preview {
    struct PhoneInput_PhoneNumberPreviewContainer : View {
        @State private var phoneNumber: String = ""
        
        var body: some View {
            PhoneInput_PhoneNumber(phoneNumber: $phoneNumber)
                .padding(.horizontal)
        }
    }
    return PhoneInput_PhoneNumberPreviewContainer()
}
