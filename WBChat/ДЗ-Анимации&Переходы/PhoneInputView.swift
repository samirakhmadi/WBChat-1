//
//  PhoneInputView.swift
//  WBChat
//
//  Created by Александр on 02.07.2024.
//

import SwiftUI


struct PhoneInputView: View {
    @Environment(\.dismiss) private var dismiss
    @State var phoneNumber: String = ""
    @State var phoneCode: String = "+7"
    
    var body: some View {
        VStack{
            textBlock
            phoneInputField
            continueButton
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ViewBackgroundColor())
    }
}

//MARK: SubViews
private extension PhoneInputView {
    
    var textBlock: some View {
        TextBlockView(title: "Введите номер телефона", subtitle: "Мы вышлем код подтверждения на указанный номер")
            .padding(.horizontal, 42)
            .padding(.top, 79)
    }
    
    var phoneInputField: some View {
        HStack(spacing: 8) {
            PhoneInput_PhoneCode(phoneCode: phoneCode, phoneNumber: $phoneNumber)
            PhoneInput_PhoneNumber(phoneNumber: $phoneNumber)
        }
        .padding(.horizontal, 24)
        .padding(.top, 49)
    }
    
    var backButton: some View {
        NavigationBackButton()
    }
    
    var continueButton: some View {
        CapsuleButton(title: "Продолжить",
                      isDisabled: !isPhoneNumberValid)
        {}
            .padding(.horizontal, 24)
            .padding(.top, 69)
    }
}

//MARK: Calculated Values
private extension PhoneInputView {
    var combinedPhoneNumber: String {
        phoneCode + " " + phoneNumber
    }
    
    var isPhoneNumberValid: Bool {
        return combinedPhoneNumber.countDigits() == 11
    }
}

#Preview {
    NavigationStack {
        PhoneInputView()
    }
}

