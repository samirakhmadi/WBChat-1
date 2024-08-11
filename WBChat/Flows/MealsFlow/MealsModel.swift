//
//  MealsModel.swift
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
    
    func fetchRandomMeal() async throws -> Meal? {
        let mealResponse = try await client.getRandomMeal(Operations.getRandomMeal.Input())
        
        switch mealResponse {
        case let .ok(response):
            switch response.body {
            case .json(let mealData):
                return mealData.meals.first
            }
        case .default(statusCode: _, _):
            return nil
        }
    }
    
    func filterByCategory(category: String) async throws -> [Meal]? {
        let mealResponse = try await client.filterByCategory(Operations.filterByCategory.Input(query: .init(c: category)))
        
        switch mealResponse {
        case let .ok(response):
            switch response.body {
            case .json(let mealData):
                return mealData.meals
            }
        case .default(statusCode: _, _):
            return nil
        }
    }
    
    func getAllCategories() async throws -> [MealCategory]?  {
        let categoriesResponse = try await client.getAllCategories(Operations.getAllCategories.Input())
        
        switch categoriesResponse {
        case let .ok(response):
            switch response.body {
            case .json(let categoriesData):
                return categoriesData.categories
            }
        case .default(statusCode:  _, _):
            return nil
        }
    }
    
    func searchMeals(mealQuery: String)  async throws -> [Meal]? {
        let mealResponse = try await client.searchMealByName(Operations.searchMealByName.Input(query: .init(s: mealQuery)))
        
        switch mealResponse {
        case let .ok(response):
            switch response.body {
            case .json(let mealsData):
                return mealsData.meals
            }
        case .default(statusCode: _, _):
            return nil
        }
    }

    func getMealById(id: String) async throws -> Meal? {
        let mealResponse =  try await client.getMealById(Operations.getMealById.Input(query: .init(i: id)))
        
        switch mealResponse {
        case let .ok(response):
            switch response.body {
            case .json(let mealsData):
                return mealsData.meals.first
            }
        case .default(statusCode: _, _):
            return nil
        }
    }
}
