// RecipesDto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - RecipesDto

/// Рецепты
struct RecipesDto: Decodable {
    ///
    let from: Int?
    let to: Int?
    let count: Int?
//    let links: LinksDto
    var hits: [Hit]
}

// MARK: - Hit

/// Хит
struct Hit: Decodable {
    var recipe: RecipeDto
}

// MARK: - Recipe

/// Рецепт
struct RecipeDto: Decodable {
    let label: String
    let image: String
    var imageBase64: String?
    let images: ImagesDto
    let url: String
    let totalTime: Int
    let ingredientLines: [String]
    let calories: Double
    let totalWeight: Double
    let dishType: [String]
    let totalNutrients: NutrinentsDto
}

// MARK: - Images

/// Рецепты
struct ImagesDto: Decodable {
    let thumbnail, small, regular: ImageDto

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
    }
}

// MARK: - Large

/// Рецепты
struct ImageDto: Decodable {
    let url: String
    let width, height: Int
}

// MARK: - Total

/// Рецепты
struct NutrinentsDto: Decodable {
    let enercKcal: NutrientDto?
    let fat: NutrientDto
    let carbohydrates: NutrientDto
    let proteins: NutrientDto

    enum CodingKeys: String, CodingKey {
        case enercKcal = "ENERC_KCAL"
        case fat = "FAT"
        case carbohydrates = "CHOCDF"
        case proteins = "PROCNT"
    }
}

// MARK: - AdditionalProp

/// Рецепты
struct NutrientDto: Decodable {
    let label: String
    let quantity: Double
    let unit: String
}
