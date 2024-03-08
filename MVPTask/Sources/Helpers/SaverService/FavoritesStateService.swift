// FavoritesStateService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис для хранения избранных рецептов
final class FavoritesStateService {
    // MARK: Constants

    static let shared = FavoritesStateService()

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private let userDefaults = UserDefaults.standard
    private let key = "SavedFavorites"

    // MARK: Initializers

    private init() {}

    // MARK: Public Methods

    func addFavorite(recipe: Recipe) {
        var savedRecipes = loadFavorites()
        guard !savedRecipes.contains(where: { $0 == recipe }) else { return }
        savedRecipes.append(recipe)
        let data = try? encoder.encode(savedRecipes)
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }

    func deleteFavorite(recipe: Recipe) {
        var savedRecipes = loadFavorites()
        guard let index = savedRecipes.firstIndex(
            where: { $0 == recipe }
        ) else { return }
        if savedRecipes.indices.contains(index) {
            savedRecipes.remove(at: index)
            let data = try? encoder.encode(savedRecipes)
            userDefaults.set(data, forKey: key)
            userDefaults.synchronize()
        }
    }

    func loadFavorites() -> [Recipe] {
        guard let data = userDefaults.object(forKey: key) as? Data,
              let recipes = try? decoder.decode([Recipe].self, from: data)
        else { return [] }
        return recipes
    }
}
