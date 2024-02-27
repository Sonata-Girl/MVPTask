// ProfileSceneCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана профиля в таббаре
final class ProfileSceneCoordinator: BaseCoordinator {
    var navigationController: UINavigationController
    var goToLoginScreen: (() -> ())?

    init(rootViewController: UIViewController) {
        navigationController = UINavigationController(
            rootViewController: rootViewController
        )
    }

    func logOut() {
        goToLoginScreen?()
    }
}
