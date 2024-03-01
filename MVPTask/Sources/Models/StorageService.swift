// StorageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Мок данные для приложения. Имитация сети
final class StorageService {
    // MARK: Private Properties

    private var recipes: [Recipe] = []
    private var categories: [Category] = []

    // MARK: Initializers

    init() {
        fillTestSources()
    }

    // MARK: Public Methods

    func getRecipes() -> [Recipe] {
        recipes
    }

    func getCategories() -> [Category] {
        categories
    }

    // MARK: Private Methods

    private func fillTestSources() {
//        / Заполнение Категорий
//        let categorySalad = Category(name: "Salad", imageName: <#T##String#>)
    }
}
