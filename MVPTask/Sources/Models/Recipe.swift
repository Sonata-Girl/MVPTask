//
//  Recipe.swift
//  MVPTask
//
//  Created by Sonata Girl on 29.02.2024.
//
//import Foundation

/// Рецепт
struct Recipe {
    /// Наименование блюда
    var name: String
    /// Категория
    var category: [Category]
    /// Время приготовления в минутах
    var cookingTimeInMinutes: Int
    /// Количество каллорий
    var caloriesCount: Int
    /// Вес в граммах
    var weightGram: Int
    /// Количество углеводов в граммах
    var сarbohydratesGram: Double
    /// Количество жиров в граммах
    var fatsGram: Double
    /// Количество протеинов в граммах
    var proteinGram: Double
}
