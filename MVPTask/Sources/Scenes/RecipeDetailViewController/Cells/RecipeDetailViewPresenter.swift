// RecipeDetailViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью экрана детализации рецепта
protocol RecipeDetailViewProtocol: AnyObject {}

/// Протокол презентера экрана детализации рецепта
protocol RecipeDetailPresenterProtocol: AnyObject {
    var recipe: Recipe? { get }
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
    }
}
