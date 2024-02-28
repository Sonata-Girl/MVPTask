// LoginSceneCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана регистрации
final class LoginSceneCoordinator: BaseCoordinator {
    // MARK: Public Properties

    var navigationController: UINavigationController
    var goToProfileScreen: (() -> ())?

    init(rootViewController: UIViewController) {
        navigationController = UINavigationController(
            rootViewController: rootViewController
        )
    }

    // MARK: Public Methods

    func tapProfile() {
        goToProfileScreen?()
    }
}
