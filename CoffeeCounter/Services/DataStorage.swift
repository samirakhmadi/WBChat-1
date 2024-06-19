//
//  DataStorage.swift
//  WBChat
//
//  Created by Александр on 19.06.2024.
//

import Foundation

final class DataStorage {
    static let shared = DataStorage()
    
    private init(){}
    
    func resetProgress(){
        let defaults = UserDefaults.standard
        let amount = defaults.double(forKey: "amount")
        defaults.setValue(amount * 0, forKey: "amount")
    }
    
    func addCoffeePortion(){
        let defaults = UserDefaults.standard
        let amount = defaults.double(forKey: "amount")
        defaults.setValue(amount + 200, forKey: "amount")
    }
    
    func loadCurrentCoffeeAmount() -> Double{
        let defaults = UserDefaults.standard
        return defaults.double(forKey: "amount")
    }
}
