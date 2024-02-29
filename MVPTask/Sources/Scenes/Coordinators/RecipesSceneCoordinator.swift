// RecipesSceneCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана рецептов в таббаре (1 вкладка)
final class RecipesSceneCoordinator: BaseCoordinator {
    // MARK: Public Properties

    var navigationController: UINavigationController?
    var finishFlowHandler: (() -> ())?

    // MARK: Public Methods

    func setRootViewController(view: UIViewController) {
        navigationController = UINavigationController(
            rootViewController: view
        )
    }

    // TODO: - Доработать добавить модель
    func showCategoryScreen( /* model */ ) {
        let categoryViewController = AppBuilder().makeCategoryRecipeModule(coordinator: self)
        navigationController?.pushViewController(categoryViewController, animated: true)
    }

    func backToRecipeScreen() {
        navigationController?.popViewController(animated: true)
    }

    func logOut() {
        finishFlowHandler?()
    }
}
