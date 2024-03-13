// RecipesDto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - RecipesDto

/// Корень получения данных рецептов
struct RecipesDTO: Decodable {
    /// От
    let from: Int?
    /// К
    let to: Int?
    /// Количество
    let count: Int?
    /// Список рецептов
    var hits: [Hit]
}

// MARK: - Hit

/// Обертка для состава рецепта
struct Hit: Decodable {
    /// Рецепт
    var recipe: RecipeDTO
}

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
    /// Количества калорий рецепта
    let calories: Double
    /// Вес рецепта
    let totalWeight: Double
    /// Тип блюда
    let dishType: [String]
    /// Состав ингредиентов
    let totalNutrients: NutrinentsDTO
}

// MARK: - ImagesDTO

/// Картинка рецепта
struct ImagesDTO: Decodable {
    /// Размер наброска картинки
    let thumbnail: ImageDTO
    /// Маленькая картинка
    let small: ImageDTO
    /// Обычный размер картинки
    let regular: ImageDTO

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
    }
}

// MARK: - ImageDTO

/// Свойства картинок рецепта
struct ImageDTO: Decodable {
    /// Адрес картинки
    let url: String
    /// Ширина , высота
    let width: Int
    /// Высота
    let height: Int
}

// MARK: - NutrinentsDto

/// Питательные вещества
struct NutrinentsDTO: Decodable {
    /// Энергетические калории
    let enercKcal: NutrientDTO?
    /// Жиры
    let fat: NutrientDTO
    /// Карбогидраты
    let carbohydrates: NutrientDTO
    /// Протеины
    let proteins: NutrientDTO

    enum CodingKeys: String, CodingKey {
        case enercKcal = "ENERC_KCAL"
        case fat = "FAT"
        case carbohydrates = "CHOCDF"
        case proteins = "PROCNT"
    }
}

// MARK: - NutrientDTO

/// Состав питательного вещества
struct NutrientDTO: Decodable {
    /// Наименование
    let label: String
    /// Количество
    let quantity: Double
    /// Единицы измерения
    let unit: String
}
