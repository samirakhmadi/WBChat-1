//
//  ListRecipeCell.swift
//  WBChat
//
//  Created by Alex on 11.08.2024.
//

import SwiftUI

struct ListRecipeCell: View {
    var meal: Meal
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .transition(.scale)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8)
            
            Text(meal.strMeal)
                .font(.headline)
        }
    }
}

#Preview {
    ListRecipeCell(meal: Meal(idMeal: "", strMeal: "soup", strInstructions: nil, strMealThumb: "sk"))
}
