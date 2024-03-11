// Recipe.swift
// Copyright © RoadMap. All rights reserved.

/// Рецепт
struct Recipe: Codable {
    /// Наименование блюда
    var name: String
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
    var imageName: String
    /// Описание детальное
    var detailDescription: String
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.name == rhs.name &&
            lhs.category.name == rhs.category.name
    }
}
