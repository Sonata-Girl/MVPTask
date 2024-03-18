// CacheService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс сервиса кэширования рецептов
protocol CacheServiceProtocol {
    ///  Кешировать рецепты
    /// - Parameter:
    /// - Returns: recipes: массив рецептов для сохранения
    func saveRecipes(recipes: [Recipe])
    ///  Кешировать рецепт
    /// - Parameter:
    /// - Returns: recipe: рецепт для сохранения
    func saveRecipe(recipe: Recipe)
    ///  Получить кешированные рецепты
    /// - Parameter:
    /// - Returns: recipes: массив рецептов
    func loadRecipes(
        dishType: String,
        qParameter: String,
        health: String
    ) -> [Recipe]

    ///  Получить кешированный рецепт
    /// - Parameter:
    /// - Returns: recipe: рецепт
    func loadRecipe(uri: String) -> Recipe?
}

final class CacheService: CacheServiceProtocol {
    weak var storage = CoreDataService.shared

    func saveRecipes(recipes: [Recipe]) {
        for recipe in recipes {
            storage?.createRecipe(recipe: recipe)
        }
    }

    func saveRecipe(recipe: Recipe) {
        storage?.createRecipe(recipe: recipe)
    }

    func loadRecipes(
        dishType: String,
        qParameter: String,
        health: String
    ) -> [Recipe] {
        if let recipesCD = storage?.fetchRecipes(
            dishType: dishType,
            qParameter: qParameter,
            health: health
        ) {
            return recipesCD.map {
                Recipe(recipeCD: $0)
            }
        }
        return []
    }

    func loadRecipe(uri: String) -> Recipe? {
        guard let recipeCD = storage?.fetchRecipe(with: uri) else { return nil }
        return Recipe(recipeCD: recipeCD)
    }
}
