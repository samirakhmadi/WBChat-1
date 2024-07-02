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


private extension PhoneInputView {
    
    var textBlock: some View {
        TextBlockView(title: "Введите номер телефона", subtitle: "Мы вышлем код подтверждения на указанный номер")
            .padding(.horizontal, 42)
            .padding(.top, 79)
    }
    
    var phoneInputField: some View {
        HStack(spacing: 8) {
            phoneCodeView
            phoneInputView
        }
        .padding(.horizontal, 24)
        .padding(.top, 49)
    }
    
    var phoneCodeView: some View {
        HStack(spacing: 8) {
            Image(.Flags.ru32X32)
                .resizable()
                .frame(width: 16, height: 16)
            Text(phoneCode)
                .foregroundStyle(phoneNumber.isEmpty ? .neutralDisabled : .neutralText)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.textFieldBackground)
        )
    }
    
    var phoneInputView: some View {
        TextField("000 000-00-00", text: $phoneNumber)
            .foregroundStyle(.neutralText)
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
    
    var backButton: some View {
        Button{
            dismiss()
        } label: {
            Image(.backIcon)
                .resizable()
                .scaledToFit()
        }
        .frame(width: 24, height: 24, alignment: .trailing)
        .tint(.neutralText)
    }
}

#Preview {
    NavigationStack {
        PhoneInputView()
    }
}

