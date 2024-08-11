//
//  MealsView.swift
//  WBChat
//
//  Created by Александр on 11.08.2024.
//

import SwiftUI
import UIComponents

struct MealsView: View {
    @State private var searchQuery = ""
    @State private var viewModel: MealsViewModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(viewModel: MealsViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        ScrollView {
            VStack {
                MealsView_SearchView(searchQuery: $searchQuery)
                //MARK: - Сюда можно добавить кнопку, которая бы вела в избранные(FavoritesView). Думаю, .sheet будет неплохо смотреться
                
                
                
                
                //MARK: -
                VStack(alignment: .leading, spacing: 8) {
                    Text("Блюдо дня")
                        .foregroundStyle(.neutralText)
                        .fontWeight(.semibold)
                    Group {
                        switch viewModel.randomMeal {
                        case .some(let meal):
                            MealsView_RandomMeal(meal: meal)
                                .onTapGesture {
                                    print(meal)
                                }
                        case .none:
                            EmptyView()
                        }
                    }
                }
                .padding(.vertical)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Категории")
                        .foregroundStyle(.neutralText)
                        .fontWeight(.semibold)
                    Group {
                        switch viewModel.categories {
                        case .some(let categories):
                            MealsView_CategoryGrid(categories: categories, columns: columns)
                        case .none:
                            EmptyView()
                        }
                    }
                }
            }
            .padding([.top, .horizontal])
        }
        .background(ViewBackgroundColor(backgroundColor: .neutral))
        .overlay {
            if viewModel.isLoading {
               MealsView_ProgressView()
            }
        }
        .task {
            try? await loadInitialData()
        }
    }
}

private extension MealsView {
    func loadInitialData() async throws {
        viewModel.isLoading = true
        defer { withAnimation(.easeInOut){viewModel.isLoading = false}}
        do {
            try await viewModel.fetchRandomMeal()
            try await viewModel.getAllCategories()
        } catch {
            print("Error fetching initial data: \(error)")
        }
    }
}



#Preview {
    NavigationStack {
        MealsView(viewModel: MealsViewModel(client: MockClient()))
    }
}
