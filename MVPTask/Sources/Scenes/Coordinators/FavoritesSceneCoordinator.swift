// FavoritesSceneCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана избранное
final class FavoritesSceneCoordinator: BaseCoordinator {
    // MARK: Public Properties

    var navigationController: UINavigationController?
    var finishFlowHandler: VoidHandler?

    // MARK: Public Methods

    func setRootViewController(view: UIViewController) {
        navigationController = UINavigationController(
            rootViewController: view
        )
    }

    func finishFlow() {
        finishFlowHandler?()
    }
}
