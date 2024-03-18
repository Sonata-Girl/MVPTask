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
    var state: ViewState<[Category]> { get }
    ///  Записать переход на экран
    func logTransition()
}

/// Презентер экрана общего списка рецептов
final class RecipesViewPresenter: RecipesViewPresenterProtocol {
    // MARK: Constants

    private enum Constants {
        static let titleScreen = "Экран рецептов"
    }

    // MARK: Private Properties

    private weak var coordinator: RecipesSceneCoordinator?
    private var storageService = StorageService()
    private weak var view: RecipesViewProtocol?
    private(set) var categories: [Category] = []
    private(set) var state: ViewState<[Category]> = .loading {
        didSet {
            view?.reloadTable()
        }
    }

    // MARK: Initializers

    init(
        view: RecipesViewProtocol?,
        coordinator: RecipesSceneCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
        filsSourse()
    }

    // MARK: Public Methods

    func logTransition() {
        log(.openScreen(screenName: Constants.titleScreen))
    }

    func loadRecipes() {
        state = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.updateState()
        }
    }

    private func updateState() {
        state = categories.isEmpty ? .noData() : .data(categories)
    }

    func goToCategoryScreen(index: Int) {
        coordinator?.showCategoryScreen(category: categories[index])
    }

    private func filsSourse() {
        categories = storageService.getCategories()
    }
}
