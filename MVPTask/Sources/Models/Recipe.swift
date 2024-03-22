// Recipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Рецепт
public struct Recipe: Codable {
    /// Наименование блюда
    var name: String
    /// Категория
    var dishType: [String]
    /// Категория
    var category: Category
    /// Время приготовления в минутах
    var cookingTimeInMinutes: Int
    /// Количество каллорий
    var caloriesCount: Int
    /// Вес в граммах
    var weightGram: Int
    /// Количество углеводов в граммах
    var carbohydratesGram: Double
    /// Количество жиров в граммах
    var fatsGram: Double
    /// Количество протеинов в граммах
    var proteinGram: Double
    /// Энергетических каллорий
    var enercKcal: Int
    /// Картинка рецепта
    var imageBase64: String
    /// Картинка рецепта
    var imageData: Data?
    /// Адрес картинки рецепта
    var imageUrl: String
    /// Описание детальное
    var detailDescription: String
    /// Ссылка для получения рецепта
    var uri: String

    init(dto: RecipeDTO) {
        name = dto.label
        dishType = dto.dishType
        cookingTimeInMinutes = dto.totalTime
        caloriesCount = Int(dto.calories)
        weightGram = Int(dto.totalWeight)
        carbohydratesGram = dto.totalNutrients.carbohydrates.quantity
        fatsGram = dto.totalNutrients.fat.quantity
        proteinGram = dto.totalNutrients.proteins.quantity
        enercKcal = Int(dto.totalNutrients.enercKcal?.quantity ?? 0)
        imageBase64 = dto.imageBase64 ?? ""
        detailDescription = dto.ingredientLines.joined(separator: "\n")
        category = .init(name: "", imageName: "")
        uri = dto.uri
        imageUrl = dto.images.regular.url
    }
}

extension Recipe: Equatable {
    public static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.name == rhs.name &&
            lhs.category.name == rhs.category.name
    }
}

extension Recipe {
    init(recipeCD: RecipeCD) {
        name = recipeCD.name ?? ""
        cookingTimeInMinutes = Int(recipeCD.cookingTimeInMinutes)
        caloriesCount = Int(recipeCD.caloriesCount)
        weightGram = Int(recipeCD.weightGram)
        carbohydratesGram = recipeCD.carbohydratesGram
        fatsGram = recipeCD.fatsGram
        proteinGram = recipeCD.proteinGram
        enercKcal = Int(recipeCD.enercKcal)
        imageBase64 = recipeCD.imageBase64 ?? ""
        detailDescription = recipeCD.detailDescription ?? ""
        category = .init(name: "", imageName: "")
        uri = recipeCD.uri ?? ""
        imageUrl = recipeCD.imageUrl ?? ""
        dishType = [recipeCD.dishType ?? ""]
    }
}
