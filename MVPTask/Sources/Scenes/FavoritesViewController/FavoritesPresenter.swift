// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

//
//  FavoritesViewPresenter.swift
//  MVPTask
//
//  Created by Алексей Барлетов on 03.03.2024.
//
import UIKit

/// Протокол презентера экрана избранное
protocol FavoritesPresenterProtocol: AnyObject {
    /// Получение рецептов для таблицы
    func getRecipes() -> [Recipe]
    func deleteElement(index: Int)
    func examinationEmptyElement()
}

/// Презентер экрана избранное
final class FavoritesPresenter {
    private var recipes: [Recipe]?
    private let storageSource = StorageService()

    // MARK: Public Properties

    private weak var coordinator: FavoritesSceneCoordinator?

    // MARK: Private Properties

    private weak var view: FavoritesViewProtocol?

    // MARK: Initializers

    init(
        view: FavoritesView?,
        coordinator: FavoritesSceneCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
        fillSources()
    }
}

// MARK: Extension + FavoritesPresenterProtocol

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func examinationEmptyElement() {
        guard let recipes = recipes else { return }
        view?.showView(element: !recipes.isEmpty)
    }

    func deleteElement(index: Int) {
        if let recipes, recipes.indices.contains(index) {
            self.recipes?.remove(at: index)
            FavoritesStateService.shared.deleteFavorite(recipe: recipes[index])
        }
    }

    func getRecipes() -> [Recipe] {
        fillSources()
        return recipes ?? []
    }

    private func fillSources() {
        recipes = FavoritesStateService.shared.loadFavorites()
    }
}
