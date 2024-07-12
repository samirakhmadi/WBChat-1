//
//  VerificationModel.swift
//  WBChat
//
//  Created by Александр on 11.07.2024.
//

import Foundation

struct VerificationModel {
    var phoneNumber: String
    private(set) var verificationCode: [Character]
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        self.verificationCode = String(format: "%04d", Int.random(in: 0..<10000)).map { $0 }
    }
    
    func validate(code: String) -> Bool {
        return String(verificationCode) == code
    }
    
    mutating func regenerateVerificationCode() {
        verificationCode = String(format: "%04d", Int.random(in: 0..<10000)).map { $0 }
    }
}

extension VerificationModel: Sequence {
    func makeIterator() -> some IteratorProtocol {
        VerificationIterator(code: verificationCode)
    }
}

extension VerificationModel: Hashable {}

struct VerificationIterator: IteratorProtocol {
    private var code: [Character]
    private var index = 0
    
    init(code: [Character]) {
        self.code = code
    }
    
    mutating func next() -> Character? {
        guard index < code.count else { return nil }
        let char = index % 2 == 0 ? code[index] : "*"
        index += 1
        return char
    }
}
