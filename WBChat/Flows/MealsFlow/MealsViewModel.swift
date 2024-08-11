//
//  MealsViewModel.swift
//  WBChat
//
//  Created by Александр on 11.08.2024.
//

import Foundation
import OpenAPIURLSession
import OpenAPIRuntime

typealias Meal = Components.Schemas.Meal
typealias MealCategory = Components.Schemas.MealCategory

struct MealsViewModel {
    
    private let client: APIProtocol
    
    init(client: APIProtocol) {
        self.client = client
    }
    
    var randomMeal: Meal?
    
    var selectedMeal: Meal?
    
    var meals: [Meal]?
    
    var categories: [MealCategory]?
    
    var isLoading: Bool = false
    
    var isShowingSearchResult: Bool = false
    
    var isShowingDetail: Bool = false
    
    init() {
        do {
            let serverURL = try Servers.server1()
            self.client = Client(
                serverURL: serverURL,
                transport: URLSessionTransport()
            )
        } catch {
            fatalError("Ошибка при получении serverURL: \(error)")
        }
    }
    
    mutating func fetchRandomMeal() async throws {
        let mealResponse = try await client.getRandomMeal(Operations.getRandomMeal.Input())
        
        switch mealResponse {
        case let .ok(response):
            switch response.body {
            case .json(let mealData):
                randomMeal = mealData.meals.first
            }
        case .default(statusCode: let code, _):
            print("\(code)")
        }
    }
    
    mutating func filterByCategory(category: String) async throws {
        let mealResponse = try await client.filterByCategory(Operations.filterByCategory.Input(query: .init(c: category)))
        
        switch mealResponse {
        case let .ok(response):
            switch response.body {
            case .json(let mealData):
                meals = mealData.meals
            }
        case .default(statusCode: let code, _):
            print("\(code)")
        }
    }
    
    mutating func getAllCategories() async throws {
        let categoriesResponse = try await client.getAllCategories(Operations.getAllCategories.Input())
        
        switch categoriesResponse {
        case let .ok(response):
            switch response.body {
            case .json(let categoriesData):
                categories = categoriesData.categories
            }
        case .default(statusCode: let code, _):
            print("\(code)")
        }
    }
    
    mutating func searchMeals(mealQuery: String)  async throws  {
        let mealResponse = try await client.searchMealByName(Operations.searchMealByName.Input(query: .init(s: mealQuery)))
        
        switch mealResponse {
        case let .ok(response):
            switch response.body {
            case .json(let mealsData):
                meals = mealsData.meals
            }
        case .default(statusCode: let code, _):
            print("\(code)")
        }
    }

    mutating func getMealById(id: String) async throws  {
        let mealResponse =  try await client.getMealById(Operations.getMealById.Input(query: .init(i: id)))
        
        switch mealResponse {
        case let .ok(response):
            switch response.body {
            case .json(let mealsData):
                selectedMeal = mealsData.meals.first
            }
        case .default(statusCode: let code, _):
            print("\(code)")
        }
    }
}
