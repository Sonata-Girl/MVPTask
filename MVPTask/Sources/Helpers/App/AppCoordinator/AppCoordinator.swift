// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор приложения
final class AppCoordinator: BaseCoordinator {
    private var mainTabBarController: MainTabBarController?
    private var appBuilder = AppBuilder()

    // TODO: Будет дорабатываться
    override func start() {
        if true {
            goToMainTabBarController()
        } else {
            goToLoginController()
        }
    }

    // TODO: Будет дорабатываться
    func goToMainTabBarController() {
        mainTabBarController = MainTabBarController()
        guard let mainTabBarController else { return }
        let recipesCoordinator = RecipesSceneCoordinator()
        let recipeModuleView = appBuilder.makeRecipesModule(coordinator: recipesCoordinator)
        recipesCoordinator.setRootViewController(view: recipeModuleView)
        add(coordinator: recipesCoordinator)

        let favoritesModuleView = appBuilder.makeFavoritesModule()
        //        add(coordinator: tabBarCoordinator)

        let profileCoordinator = ProfileSceneCoordinator()
        let profileModuleView = appBuilder.makeProfileModule(coordinator: profileCoordinator)
        profileCoordinator.setRootViewController(view: profileModuleView)
        profileCoordinator.finishFlowHandler = { [weak self] in
            self?.remove(coordinator: profileCoordinator)
            self?.mainTabBarController = nil
            self?.goToLoginController()
        }

        add(coordinator: profileCoordinator)

        guard let navigationController = profileCoordinator.navigationController else { return }
        mainTabBarController.setViewControllers(
            [
                recipeModuleView,
                favoritesModuleView,
                navigationController
            ],
            animated: true
        )

        setAsRoot​(​_​: mainTabBarController)
    }

    func goToLoginController() {
        let loginCoordinator = LoginSceneCoordinator()
        let loginViewController = appBuilder.makeLoginModule(coordinator: loginCoordinator)
        loginCoordinator.setRootViewController(view: loginViewController)
        loginCoordinator.finishFlowHandler = { [weak self] in
            self?.remove(coordinator: loginCoordinator)
            self?.goToMainTabBarController()
        }
        add(coordinator: loginCoordinator)
        setAsRoot​(​_​: loginViewController)
    }
}
