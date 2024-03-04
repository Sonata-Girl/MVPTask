// FavoritesSceneCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана избранное
final class FavoritesSceneCoordinator: BaseCoordinator {
    // MARK: Public Properties

    var navigationController: UINavigationController?
    var finishFlowHandler: (() -> ())?

    // MARK: Public Methode

    func setRootViewController(view: UIViewController) {
        navigationController = UINavigationController(
            rootViewController: view
        )
    }

    func showCategoryScreen(category: Category) {
        let favoriteViewController = AppBuilder().makeFavoritesModule(coordinator: self)
        navigationController?.pushViewController(favoriteViewController, animated: true)
    }

    func tapProfile() {
        finishFlowHandler?()
    }
}
