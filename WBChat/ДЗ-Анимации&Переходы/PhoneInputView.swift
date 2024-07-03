//
//  PhoneInputView.swift
//  WBChat
//
//  Created by Александр on 02.07.2024.
//

import SwiftUI


struct PhoneInputView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var selectedCountry: Countries = .russia
    @State var phoneNumber: String = ""
    @State var showCodeMenu: Bool = false
    
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
            .offset(y: isPhoneNumberValid ? -400 : 0)
            .animation(.easeInOut(duration: 1), value: isPhoneNumberValid)
    }
    
    var phoneInputField: some View {
        HStack(alignment: .top, spacing: 8) {
            switch showCodeMenu {
            case false:
                PhoneInput_PhoneCode(selectedCountry: $selectedCountry, phoneNumber: $phoneNumber, showCodeMenu: $showCodeMenu)
            case true:
                PhoneInput_PhoneCodeMenu(selectedCountry: $selectedCountry, showCodeMenu: $showCodeMenu)
            }
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
        selectedCountry.phoneCode + " " + phoneNumber
    }
    
    var isPhoneNumberValid: Bool {
        return combinedPhoneNumber.countDigits() == selectedCountry.phoneNumberLength
    }
}

#Preview {
    NavigationStack {
        PhoneInputView()
    }
}

