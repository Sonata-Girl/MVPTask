// RecipesDTO.swift
// Copyright © RoadMap. All rights reserved.

/// Корень получения данных рецептов
struct RecipesDTO: Decodable {
    /// От
    let from: Int?
    /// К
    let to: Int?
    /// Количество
    let count: Int?
    /// Список рецептов
    var hits: [HitDTO]
}
