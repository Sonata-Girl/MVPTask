// RecipesViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью экрана общего списка рецептов
protocol RecipesViewProtocol: AnyObject {}

/// Протокол презентера экрана общего списка рецептов
protocol RecipesViewPresenterProtocol: AnyObject {
    /// Инициация перехода на экран категории
    func goToCategoryScreen(index: Int)
}

/// Презентер экрана общего списка рецептов
final class RecipesViewPresenter: RecipesViewPresenterProtocol {
    // MARK: Constants

    // MARK: Public Properties

    private weak var coordinator: RecipesSceneCoordinator?

    // MARK: Private Properties

    private weak var view: RecipesViewProtocol?
    private(set) var categories: [Category] = []
    // MARK: Initializers

    init(
        view: RecipesViewProtocol?,
        coordinator: RecipesSceneCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
    }

    func goToCategoryScreen(index: Int) {
        coordinator?.showCategoryScreen(category: categories[index])
    }
}
