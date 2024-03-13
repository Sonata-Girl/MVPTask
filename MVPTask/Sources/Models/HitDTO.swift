// HitDTO.swift
// Copyright © RoadMap. All rights reserved.

// MARK: - HitDTO

/// Обертка для состава рецепта
struct HitDTO: Decodable {
    /// Рецепт
    var recipe: RecipeDTO
}
