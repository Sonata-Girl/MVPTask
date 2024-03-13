// ImageDTO.swift
// Copyright © RoadMap. All rights reserved.

/// Свойства картинок рецепта
struct ImageDTO: Decodable {
    /// Адрес картинки
    let url: String
    /// Ширина
    let width: Int
    /// Высота
    let height: Int
}
