//
//  Destination.swift
//  WBChat
//
//  Created by Александр on 11.07.2024.
//

import SwiftUI

enum Destination {
    case termsOfUse
    case phoneInput
    case codeVerification(Binding<VerificationModel>)
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .termsOfUse:
            EmptyView()
        case .phoneInput:
            PhoneInputView()
        case .codeVerification(let verificationModel):
            CodeVerificationView(verificationModel: verificationModel)
        }
    }
}

extension Destination: Hashable {
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        switch (lhs, rhs) {
        case (.phoneInput, .phoneInput):
            return true
        case (.codeVerification(let lhsVerification), .codeVerification(let rhsVerification)):
            return lhsVerification.wrappedValue == rhsVerification.wrappedValue
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .termsOfUse:
            hasher.combine("termsOfUse")
        case .phoneInput:
            hasher.combine("phoneInput")
        case .codeVerification(let verificationData):
            hasher.combine("codeVerification")
            hasher.combine(verificationData.wrappedValue)
        }
    }
}
