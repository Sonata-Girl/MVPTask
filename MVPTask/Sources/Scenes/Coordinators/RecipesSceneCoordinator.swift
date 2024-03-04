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

    func showCategoryScreen(category: Category) {
        let categoryViewController = AppBuilder().makeCategoryRecipeModule(coordinator: self)
        categoryViewController.setTitle(title: category.name)
        navigationController?.pushViewController(categoryViewController, animated: true)
    }

    func goToDetailRecipeScreen(recipe: Recipe) {
        let detailRecipeViewController = AppBuilder().makeDetailRecipeModule(coordinator: self, recipe: recipe)
        navigationController?.pushViewController(detailRecipeViewController, animated: true)
    }

    func backToPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }

    func logOut() {
        finishFlowHandler?()
    }
}
