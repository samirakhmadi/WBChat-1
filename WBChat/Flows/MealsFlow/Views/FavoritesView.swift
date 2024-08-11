//
//  ListRecipeCell.swift
//  WBChat
//
//  Created by Alex on 11.08.2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("backgroundColor")
                    .edgesIgnoringSafeArea(.all)
                
                if favoritesViewModel.favoriteMeals.isEmpty {
                   
                    Text("NoFavorites".localized)
                        .foregroundColor(.secondary)
                        .font(.headline)
                } else {
                    List {
                        ForEach(favoritesViewModel.favoriteMeals, id: \.idMeal) { meal in
                            NavigationLink(destination: MealDetailView(meal: meal)
                                .environmentObject(favoritesViewModel)) {
                                    ListRecipeCell(meal: meal)
                                }
                                .listRowBackground(Color("backgroundColor"))
                        }
                        .onDelete(perform: deleteFavorite)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color("backgroundColor"))
                }
            }
            .navigationTitle("❤️ \("Favorites".localized)")
        }
    }
    
    private func deleteFavorite(at offsets: IndexSet) {
        for index in offsets {
            let meal = favoritesViewModel.favoriteMeals[index]
            favoritesViewModel.removeFavorite(meal)
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesViewModel())
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}
