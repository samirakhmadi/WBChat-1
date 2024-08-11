//
//  MealsView_RandomMeal.swift
//  WBChat
//
//  Created by Александр on 11.08.2024.
//

import SwiftUI

struct MealsView_RandomMeal: View {
    
    var meal: Meal
    
    var body: some View {
        AsyncImage(
            url: URL(string: meal.strMealThumb),
            transaction: .init(animation: .spring))
        { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let mealImage):
                mealImage
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
            case .failure(_):
                Color.brand.opacity(0.2)
            @unknown default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(RoundedRectangle(cornerRadius: 10).fill(.brand.opacity(0.2)))
        .overlay(alignment: .topTrailing) {
            Text(flagEmoji(for: meal.strArea ?? ""))
                .padding(5)
                .background(Circle().fill(.ultraThinMaterial))
                .padding(5)
        }
        .overlay(alignment: .leading) {
            Text(meal.strMeal)
                .modifier(BodyText1())
                .foregroundStyle(.neutralText)
                .frame(width: 100, height: 100)
                .multilineTextAlignment(.leading)
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 10).fill(.ultraThinMaterial))
                .padding(8)
            
                
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .contentShape(RoundedRectangle(cornerRadius: 10))
        
    }
}

#Preview {
    MealsView_RandomMeal(
        meal: .init(
            idMeal: "1",
            strMeal: "Baked salmon with fennel & tomatoes with fennel & tomatoes",
            strArea: "Italian",
            strMealThumb: "https://www.themealdb.com/images/media/meals/1548772327.jpg"
        )
    )
    .padding()
}


func flagEmoji(for country: String) -> String {
    let countryToEmoji: [String: String] = [
        "American": "🇺🇸",
        "British": "🇬🇧",
        "Canadian": "🇨🇦",
        "Chinese": "🇨🇳",
        "Croatian": "🇭🇷",
        "Dutch": "🇳🇱",
        "Egyptian": "🇪🇬",
        "Filipino": "🇵🇭",
        "French": "🇫🇷",
        "Greek": "🇬🇷",
        "Indian": "🇮🇳",
        "Irish": "🇮🇪",
        "Italian": "🇮🇹",
        "Jamaican": "🇯🇲",
        "Japanese": "🇯🇵",
        "Kenyan": "🇰🇪",
        "Malaysian": "🇲🇾",
        "Mexican": "🇲🇽",
        "Moroccan": "🇲🇦",
        "Polish": "🇵🇱",
        "Portuguese": "🇵🇹",
        "Russian": "🇷🇺",
        "Spanish": "🇪🇸",
        "Thai": "🇹🇭",
        "Tunisian": "🇹🇳",
        "Turkish": "🇹🇷",
        "Ukrainian": "🇺🇦",
        "Vietnamese": "🇻🇳"
    ]
    
    return countryToEmoji[country] ?? "🏳️"
}
