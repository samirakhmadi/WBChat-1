//
//  Extension+Double.swift
//  WBChat
//
//  Created by Александр on 06.08.2024.
//

import Foundation

extension Double {
    func formatDuration() -> String {
        let minutes = Int(self) / 60
        let remainingSeconds = Int(self) % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
}
