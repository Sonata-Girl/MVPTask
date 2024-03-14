// RecipeDetailViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью экрана детализации рецепта
protocol RecipeDetailViewProtocol: AnyObject {
    /// Перезагрузить таблицу
    func reloadTable()
    /// Загрузить изображение
    func loadImage(imageBase64: String)
    /// Остановить обновление страницы
    func stopRefreshing()
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
    func loadRecipe(refresh: Bool)
    //// Состояние загрузки
    var state: ViewState<Recipe> { get }
}

/// Презентер экрана детализации рецепта
final class RecipeDetailViewPresenter: RecipeDetailPresenterProtocol {
    // MARK: Private Properties

    private weak var view: RecipeDetailViewProtocol?
    private let networkService: NetworkServiceProtocol?
    private let proxyImageService: LoadImageServiceProtocol?
    private weak var coordinator: RecipesSceneCoordinator?
    private(set) var recipe: Recipe?
    private(set) var uri: String?
    private(set) var state: ViewState<Recipe> = .loading {
        didSet {
            view?.reloadTable()
        }
    }

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
        proxyImageService = ProxyLoadService(service: LoadImageService())
    }

    // MARK: Public Methods

    func loadRecipe(refresh: Bool) {
        state = .loading
        guard let uri else { return }
        networkService?.getRecipe(
            uri: uri,
            completion: { [weak self] result in
                switch result {
                case let .success(recipe):
                    self?.recipe = recipe
                    DispatchQueue.main.async {
                        sleep(2)
                        self?.state = .data(recipe)
                        if refresh {
                            self?.view?.stopRefreshing()
                        }
                    }
                    self?.loadImage()
                case let .failure(error):
                    self?.state = .error(error) {}
                }
            }
        )
    }

    private func loadImage() {
        guard var recipe else { return }
        guard let url = URL(string: recipe.imageUrl) else { return }
        proxyImageService?.loadImage(url: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else { return }
            let base64Image = data.base64EncodedString()
            recipe.imageBase64 = base64Image
            DispatchQueue.main.async {
                self.view?.loadImage(imageBase64: base64Image)
            }
        }
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
