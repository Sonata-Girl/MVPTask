// ImagesDTO.swift
// Copyright © RoadMap. All rights reserved.

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
