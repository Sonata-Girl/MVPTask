// RecipeDetailViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью экрана детализации рецепта
protocol RecipeDetailViewProtocol: AnyObject {
    /// Перезагрузить таблицу
    func reloadTable()
    /// Показать ошибку
    func showErrorAlert(error: String)
}

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
    /// Загрузка данных рецепта
    func loadRecipe()
}

/// Презентер экрана детализации рецепта
final class RecipeDetailViewPresenter: RecipeDetailPresenterProtocol {
    // MARK: Private Properties

    private weak var view: RecipeDetailViewProtocol?
    private let networkService: NetworkServiceProtocol?
    private weak var coordinator: RecipesSceneCoordinator?
    private(set) var recipe: Recipe?
    private(set) var uri: String?

    // MARK: Initializers

    init(
        view: RecipeDetailViewProtocol,
        coordinator: RecipesSceneCoordinator,
        networkService: NetworkServiceProtocol,
        uri: String
    ) {
        self.view = view
        self.coordinator = coordinator
        self.networkService = networkService
        self.uri = uri
    }

    // MARK: Public Methods

    func loadRecipe() {
        guard let uri else { return }
        networkService?.getRecipe(
            uri: uri,
            completion: { [weak self] result in
                guard let self else { return }
                switch result {
                case let .success(recipe):
                    self.recipe = recipe
                    self.view?.reloadTable()
                case let .failure(error):
                    self.view?.showErrorAlert(error: error.localizedDescription)
                }
            }
        )
    }

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
