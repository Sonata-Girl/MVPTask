// LoginSceneCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана регистрации
final class LoginSceneCoordinator: BaseCoordinator {
    var navigationController: UINavigationController
    var goToProfileScreen: (() -> ())?

    init(rootViewController: UIViewController) {
        navigationController = UINavigationController(
            rootViewController: rootViewController
        )
    }

    func tapProfile() {
        goToProfileScreen?()
    }
}
