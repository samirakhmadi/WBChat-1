//
//  ResetCoffeeIntent.swift
//  WBChat
//
//  Created by Александр on 18.06.2024.
//

import AppIntents

struct ResetCoffeeIntent: AppIntent {
    static var title: LocalizedStringResource = "Сбросить прогресс"
    static var description: IntentDescription = "Сбросить счетчик выпитого кофе и начать заново, ведь кофе много не бывает😁"

    
    func perform() async throws -> some IntentResult {
        DataStorage.shared.resetProgress()
        return .result()
    }
}


