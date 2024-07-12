//
//  PhoneInputView.swift
//  WBChat
//
//  Created by Александр on 02.07.2024.
//

import SwiftUI


struct PhoneInputView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    @State private var selectedCountry: Country = .russia
    @State private var phoneNumber: String = ""
    @State private var verificationData: VerificationModel = .init(phoneNumber: "")
    
    @State private var showCodeMenu: Bool = false
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
        .onTapGesture {
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
        NavigationBackButton {
            coordinator.pop()
        }
    }
    
    var continueButton: some View {
        CapsuleButton(title: Localization.continueText.rawValue,
                      isDisabled: !isPhoneNumberValid)
        {
            verificationData.phoneNumber = combinedPhoneNumber
            coordinator.navigate(to: .codeVerification($verificationData))
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
            .environmentObject(NavigationCoordinator())
    }
}

