//
//  IncreaseCoffeeIntent.swift
//  WBChat
//
//  Created by Александр on 18.06.2024.
//

import AppIntents

struct IncreaseCoffeeIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Добавить выпитую порцию кофе"
    static var description: IntentDescription = "Добавить 200 мл к общему объему выпитого кофе.\nP.s. 200 мл (минимальный объем стаканчика) кофе соседней кофейни)"
    
    func perform() async throws -> some IntentResult {
        DataStorage.shared.addCoffeePortion()
        return .result()
    }
}
