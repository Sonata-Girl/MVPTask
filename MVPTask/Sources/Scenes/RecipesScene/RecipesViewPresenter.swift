// RecipesViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

import UIKit

/// Протокол вью экрана общего списка рецептов
protocol RecipesViewProtocol: AnyObject {}

/// Протокол презентера экрана общего списка рецептов
protocol RecipesViewPresenterProtocol: AnyObject {
        func goToCategoryScreen()
}

/// Презентер экрана общего списка рецептов
final class RecipesViewPresenter: RecipesViewPresenterProtocol {
   
    
    // MARK: Constants

    // MARK: Public Properties

    private weak var coordinator: RecipesSceneCoordinator?

    // MARK: Private Properties

    private weak var view: RecipesViewProtocol?

    // MARK: Initializers

    init(
        view: RecipesViewProtocol?,
        coordinator: RecipesSceneCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
    }
    func goToCategoryScreen() {
        
    }
}
