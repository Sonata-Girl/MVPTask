// LoginSceneCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана регистрации
final class LoginSceneCoordinator: BaseCoordinator {
    // MARK: Public Properties

    var navigationController: UINavigationController?
    var finishFlowHandler: (() -> ())?

    // MARK: Public Methods

    func setRootViewController(view: UIViewController) {
        navigationController = UINavigationController(
            rootViewController: view
        )
    }

    func tapProfile() {
        finishFlowHandler?()
    }
}
