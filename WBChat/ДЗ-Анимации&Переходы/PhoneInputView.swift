//
//  PhoneInputView.swift
//  WBChat
//
//  Created by Александр on 02.07.2024.
//

import SwiftUI


struct PhoneInputView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var selectedCountry: Country = .russia
    @State var phoneNumber: String = ""
    @State var showCodeMenu: Bool = false
    
    @State private var showProgress: Bool = false
    
    var body: some View {
        VStack{
            textBlock
            phoneInputField
            continueButton
            progressView
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
        .onChange(of: isPhoneNumberValid) { _ in
           hideKeyboard()
        }
    }
}

//MARK: SubViews
private extension PhoneInputView {
    
    var textBlock: some View {
        TextBlockView(
            title: Localization.inputPhoneText.rawValue,
            subtitle: Localization.inputPhoneDescriptionText.rawValue)
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
        CapsuleButton(title: Localization.continueText.rawValue,
                      isDisabled: !isPhoneNumberValid)
        {
            showProgress.toggle()
        }
            .padding(.horizontal, 24)
            .padding(.top, 69)
            
    }
    
    var progressView: some View {
        LoadingProgress(showProgress: showProgress)
            .padding(.vertical, 16)
    }
}

//MARK: Calculated Values
private extension PhoneInputView {
    var combinedPhoneNumber: String {
        selectedCountry.phoneCode + " " + phoneNumber
    }
    
    var isPhoneNumberValid: Bool {
        return phoneNumber.countDigits() == 10
    }
}

#Preview("Rus.ver") {
    NavigationStack {
        PhoneInputView()
            .environment(\.locale, .init(identifier: "ru"))
    }
}

#Preview("Ang.ver") {
    NavigationStack {
        PhoneInputView()
            .environment(\.locale, .init(identifier: "en"))
    }
}

#Preview("Arm.ver") {
    NavigationStack {
        PhoneInputView()
            .environment(\.locale, .init(identifier: "hy_AM"))
    }
}

#Preview("Kaz.ver") {
    NavigationStack {
        PhoneInputView()
            .environment(\.locale, .init(identifier: "kk_KZ"))
    }
}
