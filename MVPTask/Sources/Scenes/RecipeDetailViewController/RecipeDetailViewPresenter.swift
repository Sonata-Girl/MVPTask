// RecipeDetailViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью экрана детализации рецепта
protocol RecipeDetailViewProtocol: AnyObject {}

/// Протокол презентера экрана детализации рецепта
protocol RecipeDetailPresenterProtocol: AnyObject {
    /// Рецепт
    var recipe: Recipe? { get }
    /// Возврат на экран категории
    func backToCategoryScreen()
    ///  Записать переход на экран
    func logTransition()
    ///  Записать действие поделиться рецептом
    func logShare()
    /// Добавление рецепта в избранные
    func addToFavorites()
}

/// Презентер экрана детализации рецепта
final class RecipeDetailViewPresenter: RecipeDetailPresenterProtocol {
    // MARK: Private Properties

    private weak var view: RecipeDetailViewProtocol?
    private weak var coordinator: RecipesSceneCoordinator?
    private(set) var recipe: Recipe?

    // MARK: Initializers

    init(
        view: RecipeDetailViewProtocol,
        coordinator: RecipesSceneCoordinator,
        recipe: Recipe
    ) {
        self.view = view
        self.coordinator = coordinator
        self.recipe = recipe
    }

    // MARK: Public Methods

    func logTransition() {
        log(.openRecipe(recipeName: recipe?.name ?? ""))
    }

    func logShare() {
        log(.shareRecipe(recipeName: recipe?.name ?? ""))
    }

    func backToCategoryScreen() {
        coordinator?.backToPreviousScreen()
    }

    func addToFavorites() {
        guard let recipe else { return }
        FavoritesStateService.shared.addFavorite(recipe: recipe)
    }
}
