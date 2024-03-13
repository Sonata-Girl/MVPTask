// NutrientsDTO.swift
// Copyright © RoadMap. All rights reserved.

// MARK: - NutrinentsDto

/// Питательные вещества
struct NutrinentsDTO: Decodable {
    /// Энергетические калории
    let enercKcal: NutrientDTO?
    /// Жиры
    let fat: NutrientDTO
    /// Углеводы
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
