//
//  MealsView_CategoryGrid.swift
//  WBChat
//
//  Created by Александр on 11.08.2024.
//

import SwiftUI

struct MealsView_CategoryGrid: View {
    var categories: [MealCategory]
    var columns: [GridItem]
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(categories, id: \.idCategory) { category in
                AsyncImage(url: URL(string: category.strCategoryThumb), transaction: Transaction(animation: .spring)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 150, height: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    case .failure(_):
                        Color.brand.opacity(0.8)
                            .frame(width: 150, height: 150)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(alignment: .bottom) {
                    Text(category.strCategory)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.thickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}

#Preview {
    MealsView_CategoryGrid(
        categories: [
            .init(
                idCategory: "1",
                strCategory: "Beef",
                strCategoryThumb: "https://www.themealdb.com/images/media/meals/atd5sh1583188467.jpg"
            ),
            .init(
                idCategory: "2",
                strCategory: "Fish",
                strCategoryThumb: "https://www.themealdb.com/images/media/meals/atd5sh1583188467.jpg"
            )
        ],
        columns: [
            GridItem(.flexible()),
            GridItem(.flexible())]
    )
}
