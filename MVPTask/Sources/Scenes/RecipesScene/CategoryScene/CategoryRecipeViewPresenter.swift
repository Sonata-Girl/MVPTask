// CategoryRecipeViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол вью экрана списка рецептов одной категории
protocol CategoryRecipeViewProtocol: AnyObject {
    func setTitle(title: String)
}

/// Протокол презентера экрана списка рецептов одной категории
protocol CategoryRecipeViewPresenterProtocol: AnyObject {
    /// Переход на экран рецептов по кнопке возврата
    func backToRecipeScreen()
    /// Получение рецептов для таблицы
    func getRecipes() -> [Recipe]
}

/// Презентер экрана списка рецептов одной категории
final class CategoryRecipeViewPresenter: CategoryRecipeViewPresenterProtocol {
  
    // MARK: Public Properties

    private weak var coordinator: RecipesSceneCoordinator?

    // MARK: Private Properties

    private weak var view: CategoryRecipeViewProtocol?
    private let storageSource = StorageService()
    private var recipes: [Recipe]?
    private var category: Category?

    // MARK: Initializers

    init(
        view: CategoryRecipeViewProtocol?,
        coordinator: RecipesSceneCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
        fillSources()
        view?.setTitle(title: category?.name ?? "")
    }

    func getRecipes() -> [Recipe] {
        recipes ?? []
    }

    func backToRecipeScreen() {
        coordinator?.backToRecipeScreen()
    }

    private func fillSources() {
        recipes = storageSource.getRecipes()
        category = recipes?.last?.category
    }
}
