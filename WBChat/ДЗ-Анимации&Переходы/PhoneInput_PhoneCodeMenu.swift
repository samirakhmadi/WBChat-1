//
//  PhoneInput_PhoneCodeMenu.swift
//  WBChat
//
//  Created by Александр on 03.07.2024.
//

import SwiftUI

struct PhoneInput_PhoneCodeMenu: View {
    
    @Binding var selectedCountry: Countries
    @Binding var showCodeMenu: Bool
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(Countries.allCases) { country in
                    Button {
                        withAnimation(.easeInOut) {
                            selectedCountry = country
                            showCodeMenu = false
                        }
                    } label: {
                        HStack(spacing: 8){
                            Image(country.flagIcon)
                                .resizable()
                                .frame(width: 16, height: 16)
                            Text(country.phoneCode)
                                .foregroundStyle(.neutralDisabled)
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.neutral)
                    )
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.textFieldBackground)
        )
        .frame(width: 100, height: 150)
    }
}

#Preview {
    ZStack {
        Color.red
        PhoneInput_PhoneCodeMenu(selectedCountry: .constant(.russia), showCodeMenu: .constant(true))
    }
}
