// Category.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Категория рецептов
struct Category {
    static func category() -> [Data] {
        [
            .init(name: "Salad", imageName: "salad"),
            .init(name: "Soup", imageName: "soup"),
            .init(name: "Chicken", imageName: "chicken"),
            .init(name: "Meat", imageName: "meat"),
            .init(name: "Fish", imageName: "fish"),
            .init(name: "Side dish", imageName: "side dish"),
            .init(name: "Drinks", imageName: "drinks"),
            .init(name: "Pancake", imageName: "pancakes"),
            .init(name: "Desserts", imageName: "desserts")
        ]
    }
}

///
struct Data {
    /// Наименование
    var name: String
    /// Наименование картинки категории
    var imageName: String
}
