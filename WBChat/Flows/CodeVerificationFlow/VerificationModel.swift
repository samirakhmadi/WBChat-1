//
//  VerificationModel.swift
//  WBChat
//
//  Created by Александр on 11.07.2024.
//

import Foundation

struct VerificationModel: Hashable {
    var phoneNumber: String
    private var verificationCode: String

    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        self.verificationCode = String(format: "%04d", Int.random(in: 0..<9999))
    }

    func validate(code: String) -> Bool {
        return code == verificationCode
    }
}
