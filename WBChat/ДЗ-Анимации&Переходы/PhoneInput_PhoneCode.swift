//
//  PhoneInput_PhoneCode.swift
//  WBChat
//
//  Created by Александр on 02.07.2024.
//

import SwiftUI

struct PhoneInput_PhoneCode: View {
    
    @Binding var selectedCountry: Countries
    @Binding var phoneNumber: String
    @Binding var showCodeMenu: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Image(selectedCountry.flagIcon)
                .resizable()
                .frame(width: 16, height: 16)
            Text(selectedCountry.phoneCode)
                .foregroundStyle(phoneNumber.isEmpty ? .neutralDisabled : .neutralText)
                .fontWeight(.semibold)
                .animation(.easeInOut, value: phoneNumber)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.textFieldBackground)
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                showCodeMenu.toggle()
            }
        }
        .overlay(alignment: .top) {
            if showCodeMenu {
                PhoneInput_PhoneCodeMenu(selectedCountry: $selectedCountry, showCodeMenu: $showCodeMenu)
            }
        }
    }
}

#Preview {
    struct PhoneInput_PhoneCodePreviewContainer : View {
        @State private var phoneNumber: String = ""
        @State private var showCodeMenu: Bool = false
        
        var body: some View {
            PhoneInput_PhoneCode(selectedCountry: .constant(.russia), phoneNumber: .constant(""), showCodeMenu: $showCodeMenu)
                .padding(.horizontal)
        }
    }
    return PhoneInput_PhoneCodePreviewContainer()
}
