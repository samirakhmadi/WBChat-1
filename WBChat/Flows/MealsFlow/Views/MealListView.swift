//
//  MealListView.swift
//  WBChat
//
//  Created by Samir on 10.08.2024.
//

import SwiftUI

struct MealListView: View {
    
    @Binding var mealsViewModel: MealsViewModel
    let category: String
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(mealsViewModel.meals ?? [], id: \.idMeal) { meal in
                    NavigationLink {
                        EmptyView()
                    } label: {
                        mealRow(meal: meal)
                    }
                }
            }
            .navigationTitle("🍴 \(category)")
            .onAppear {
                Task {
                    try await mealsViewModel.filterByCategory(category: category)
                }
            }
        }
    }
}

private extension MealListView {
    func mealRow(meal: Meal) -> some View {
        HStack(spacing: 8) {
            AsyncImage(
                url: URL(string: meal.strMealThumb)
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure(_):
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8)
            Text(meal.strMeal)
                .font(.headline)
            Text(meal.strArea ?? "")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

#Preview {
    struct MealListViewPreviewContainer : View {
        @State private var vm: MealsViewModel = .init(client: MockClient())
        
        var body: some View {
            MealListView(mealsViewModel: $vm, category: "Beef")
                .padding(.horizontal)
        }
    }
    return MealListViewPreviewContainer()
}



