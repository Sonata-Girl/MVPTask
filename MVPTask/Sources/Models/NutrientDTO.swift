// NutrientDTO.swift
// Copyright © RoadMap. All rights reserved.

/// Состав питательного вещества
struct NutrientDTO: Decodable {
    /// Наименование
    let label: String
    /// Количество
    let quantity: Double
    /// Единицы измерения
    let unit: String
}
