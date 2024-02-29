// CategoryRecipeViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол вью экрана списка рецептов одной категории
protocol CategoryRecipeViewProtocol: AnyObject {}

/// Протокол презентера экрана списка рецептов одной категории
protocol CategoryRecipeViewPresenterProtocol: AnyObject {
    func backToRecipeScreen()
}

/// Презентер экрана списка рецептов одной категории
final class CategoryRecipeViewPresenter: CategoryRecipeViewPresenterProtocol {
    // MARK: Constants

    // MARK: Public Properties

    private weak var coordinator: RecipesSceneCoordinator?

    // MARK: Private Properties

    private weak var view: CategoryRecipeViewProtocol?

    // MARK: Initializers

    init(
        view: CategoryRecipeViewProtocol?,
        coordinator: RecipesSceneCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
    }

    func backToRecipeScreen() {
        coordinator?.backToRecipeScreen()
    }
}
