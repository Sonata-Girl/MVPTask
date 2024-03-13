// Recipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Рецепт
struct Recipe: Codable {
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
    /// Описание детальное
    var detailDescription: String

    init(
        name: String,
        dishType: [String] = [],

        category: Category,
        cookingTimeInMinutes: Int,
        caloriesCount: Int,
        weightGram: Int,
        carbohydratesGram: Double,
        fatsGram: Double,
        proteinGram: Double,
        enercKcal: Int,
        imageBase64: String = "",
        detailDescription: String
    ) {
        self.name = name
        self.dishType = dishType
        self.category = category
        self.cookingTimeInMinutes = cookingTimeInMinutes
        self.caloriesCount = caloriesCount
        self.weightGram = weightGram
        self.carbohydratesGram = carbohydratesGram
        self.fatsGram = fatsGram
        self.proteinGram = proteinGram
        self.enercKcal = enercKcal
        self.imageBase64 = imageBase64
        self.detailDescription = detailDescription
    }

    init(dto: RecipeDto) {
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
        detailDescription = dto.ingredientLines.joined(separator: "/n")
        category = .init(name: "", imageName: "")
    }
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.name == rhs.name &&
            lhs.category.name == rhs.category.name
    }
}
