// RecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

// MARK: - RecipeDto

/// Рецепт
struct RecipeDTO: Decodable {
    /// Название
    let label: String
    /// Адрес картинки
    let image: String
    /// Картинка в base64
    var imageBase64: String?
    /// Картинки в разных размерах
    let images: ImagesDTO
    /// Адрес рецепта
    let url: String
    /// Время приготовления
    let totalTime: Int
    /// Ингредиенты рецепта
    let ingredientLines: [String]
    /// Калорийность блюда
    let calories: Double
    /// Вес рецепта
    let totalWeight: Double
    /// Тип блюда
    let dishType: [String]
    /// Состав ингредиентов
    let totalNutrients: NutrinentsDTO
}
