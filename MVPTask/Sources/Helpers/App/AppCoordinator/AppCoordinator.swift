// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор приложения
final class AppCoordinator: BaseCoordinator {
    private var tabBarViewController: MainTabBarController?
    private var appBuilder = AppBuilder()

    override func start() {
        if "admin" == "admin" {
            goToMainTabBarController()
        } else {
            // login controller
        }
    }

    func goToMainTabBarController() {
        tabBarViewController = MainTabBarController()
        guard let tabBarViewController else { return }
        let recipeModuleView = appBuilder.createRecipesModule()
        //        add(coordinator: tabBarCoordinator)

        let favoritesModuleView = appBuilder.createFavoritesModule()
        //        add(coordinator: tabBarCoordinator)

        let profileModuleView = appBuilder.createProfileModule()
        let profileCoordinator = ProfileSceneCoordinator(rootViewController: profileModuleView)
        profileCoordinator.goToLoginScreen = { [weak self] in
            self?.remove(coordinator: profileCoordinator)
            self?.tabBarViewController = nil
            self?.goToLoginController()
        }

        profileModuleView.presenter?.coordinator = profileCoordinator
        add(coordinator: profileCoordinator)

        tabBarViewController.setViewControllers(
            [
                recipeModuleView,
                favoritesModuleView,
                profileCoordinator.navigationController
            ],
            animated: true
        )

        setAsRoot​(​_​: tabBarViewController)
    }

    func goToLoginController() {}
}
