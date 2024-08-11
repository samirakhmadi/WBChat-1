//
//  FavoritesViewModel.swift
//  WBChat
//
//  Created by Samir on 10.08.2024.
//

import SwiftUI

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favoriteMeals: [Meal] = []

    func addFavorite(_ meal: Meal) {
        if !favoriteMeals.contains(meal) {
            favoriteMeals.append(meal)
            
            showAlert(message: "\(meal.strMeal) добавлено в любимые!")
        }
    }
    
    func removeFavorite(_ meal: Meal) {
        favoriteMeals.removeAll { item in
            meal.idMeal == item.idMeal
        }
    }

    private func showAlert(message: String) {
        print(message) 
    }
}
