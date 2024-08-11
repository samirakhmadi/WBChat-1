//
//  ListRecipeCell.swift
//  WBChat
//
//  Created by Alex on 11.08.2024.
//


import SwiftUI

struct MealDetailView: View {
    let meal: Meal
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @State private var showAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                mealImageView
                mealTitleView
                mealDescriptionHeaderView
                mealDescriptionView
                addToFavoritesButton
                Spacer()
            }
            .animation(.easeInOut, value: meal)
        }
        .background(Color("backgroundColor"))
        .navigationTitle("🍲 \(meal.strMeal)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var mealImageView: some View {
        AsyncImage(url: URL(string: meal.strMealThumb)) { image in
            image
                .resizable()
                .scaledToFit()
                .transition(.opacity)
        } placeholder: {
            ProgressView()
        }
        .modifier(ImageStyle())
    }
    
    private var mealTitleView: some View {
        Text(meal.strMeal)
            .modifier(TitleStyle())
    }
    
    private var mealDescriptionHeaderView: some View {
        Text("🍴 \("Description".localized)")
            .modifier(DescriptionHeaderStyle())
    }
    
    private var mealDescriptionView: some View {
        Text(meal.strInstructions ?? "")
            .modifier(DescriptionContentStyle())
    }
    
    private var addToFavoritesButton: some View {
        Button(action: addToFavorites) {
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.white)
                Text("AddFavorite".localized)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .modifier(ButtonStyle())
        .alert(isPresented: $showAlert) {
            Alert(title: Text("AddedToFavorites".localized),
                  message: Text("\(meal.strMeal) \("BeenAdded".localized)"),
                  dismissButton: .default(Text("Ok".localized)))
        }
    }
    
    private func addToFavorites() {
        favoritesViewModel.addFavorite(meal)
        showAlert = true
    }
}

#Preview {
    MealDetailView(meal: .init(idMeal: "1", strMeal: "Beef", strMealThumb: ""))
        .environmentObject(FavoritesViewModel())
}
