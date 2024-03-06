// RecipesViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

import UIKit

/// Протокол вью экрана общего списка рецептов
protocol RecipesViewProtocol: AnyObject {
    /// Перезагрузить таблицу
    func reloadTable()
}

/// Протокол презентера экрана общего списка рецептов
protocol RecipesViewPresenterProtocol: AnyObject {
    /// Инициация перехода на экран категории
    func goToCategoryScreen(index: Int)
    var categories: [Category] { get }
    /// Загрузить данные
    func loadRecipes()
    /// Состояние загрузки
    var loadingState: Loading { get }
}

/// Презентер экрана общего списка рецептов
final class RecipesViewPresenter: RecipesViewPresenterProtocol {
    // MARK: Constants

    // MARK: Private Properties

    private weak var coordinator: RecipesSceneCoordinator?
    private var storageService = StorageService()
    private weak var view: RecipesViewProtocol?
    private(set) var categories: [Category] = []
    private(set) var loadingState: Loading = .noData

    // MARK: Initializers

    init(
        view: RecipesViewProtocol?,
        coordinator: RecipesSceneCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
        filsSourse()
    }

    func loadRecipes() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.loadingState = .loadedData
            self.view?.reloadTable()
        }
    }

    func goToCategoryScreen(index: Int) {
        coordinator?.showCategoryScreen(category: categories[index])
    }

    private func filsSourse() {
        categories = storageService.getCategories()
    }
}
