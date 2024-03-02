// RecipesViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

import UIKit

/// Протокол вью экрана общего списка рецептов
protocol RecipesViewProtocol: AnyObject {}

/// Протокол презентера экрана общего списка рецептов
protocol RecipesViewPresenterProtocol: AnyObject {
    /// Инициация перехода на экран категории
    func goToCategoryScreen(index: Int)
    var categories: [Category] { get }
}

/// Презентер экрана общего списка рецептов
final class RecipesViewPresenter: RecipesViewPresenterProtocol {
    // MARK: Constants

    // MARK: Private Properties

    private weak var coordinator: RecipesSceneCoordinator?
    private var storageService = StorageService()
    private weak var view: RecipesViewProtocol?
    private(set) var categories: [Category] = []

    // MARK: Initializers

    init(
        view: RecipesViewProtocol?,
        coordinator: RecipesSceneCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
        filsSourse()
    }

    func goToCategoryScreen(index: Int) {
        coordinator?.showCategoryScreen(category: categories[index])
    }

    private func filsSourse() {
        categories = storageService.getCategories()
    }
}
