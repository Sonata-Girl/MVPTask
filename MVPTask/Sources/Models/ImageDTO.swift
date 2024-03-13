// ImageDTO.swift
// Copyright © RoadMap. All rights reserved.

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
