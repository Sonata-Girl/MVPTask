// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол билдера приложения
protocol AppBuilderProtocol {
    /// Создание модуля экрана авторизации
    func makeLoginModule(coordinator: LoginSceneCoordinator) -> LoginViewController
    /// Создание модуля экрана рецептов (1 экран таббара)
    func makeRecipesModule(coordinator: RecipesSceneCoordinator) -> RecipesViewController
    /// Создание модуля экрана категории
    func makeCategoryRecipeModule(
        coordinator: RecipesSceneCoordinator,
        category: Category
    ) -> CategoryRecipeViewController
    /// Создание модуля экрана детализации рецепта
    func makeDetailRecipeModule(
        coordinator: RecipesSceneCoordinator,
        recipe: Recipe
    ) -> RecipeDetailViewController
    /// Создание модуля экрана избранных  (2 экран таббара)
    func makeFavoritesModule(coordinator: FavoritesSceneCoordinator) ->
        FavoritesView
    /// Создание модуля экрана профиля  (3 экран таббара)
    func makeProfileModule(coordinator: ProfileSceneCoordinator) -> ProfileViewController
    /// Создание модуля экрана бонусов
    func makeBonusesModule(coordinator: ProfileSceneCoordinator) -> BonusesViewController
}

/// Общий билдер приложения
final class AppBuilder: AppBuilderProtocol {
    // MARK: Constants

    enum Constants {
        static let recipesTitle = "Recipes"
        static let favoritesTitle = "Favorites"
        static let profileTitle = "Profile"
        static let tabBarRecipesUnselectImage = "tabBarRecipesUnselect"
        static let tabBarRecipesSelectImage = "tabBarRecipesSelect"
        static let tabBatFavoritesUnselectImage = "tabBatFavoritesUnselect"
        static let tabBarFavoritesSelectImage = "tabBarFavoritesSelect"
        static let tabBarProfileUnselectImage = "tabBarProfileUnselect"
        static let tabBarProfileSelectImage = "tabBarProfileSelect"
    }

    // MARK: Public Methods

    func makeLoginModule(coordinator: LoginSceneCoordinator) -> LoginViewController {
        let view = LoginViewController()
        let presenter = LoginViewPresenter(
            view: view,
            coordinator: coordinator
        )
        view.presenter = presenter

        return view
    }

    func makeRecipesModule(coordinator: RecipesSceneCoordinator) -> RecipesViewController {
        let view = RecipesViewController()
        let presenter = RecipesViewPresenter(
            view: view,
            coordinator: coordinator
        )
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: Constants.recipesTitle,
            image: UIImage(named: Constants.tabBarRecipesUnselectImage),
            selectedImage: UIImage(named: Constants.tabBarRecipesSelectImage)
        )
        return view
    }

    func makeCategoryRecipeModule(
        coordinator: RecipesSceneCoordinator,
        category: Category
    ) -> CategoryRecipeViewController {
        let view = CategoryRecipeViewController()
        let networkService = NetworkService()
        let presenter = CategoryRecipeViewPresenter(
            view: view,
            coordinator: coordinator,
            networkService: networkService,
            category: category
        )
        view.presenter = presenter
        return view
    }

    func makeDetailRecipeModule(
        coordinator: RecipesSceneCoordinator,
        recipe: Recipe
    ) -> RecipeDetailViewController {
        let view = RecipeDetailViewController()
        let presenter = RecipeDetailViewPresenter(
            view: view,
            coordinator: coordinator,
            recipe: recipe
        )
        view.presenter = presenter
        return view
    }

    func makeFavoritesModule(coordinator: FavoritesSceneCoordinator) -> FavoritesView {
        let view = FavoritesView()
        let presenter = FavoritesPresenter(
            view: view,
            coordinator: coordinator
        )
        view.presenter = presenter

        view.tabBarItem = UITabBarItem(
            title: Constants.favoritesTitle,
            image: UIImage(named: Constants.tabBatFavoritesUnselectImage),
            selectedImage: UIImage(named: Constants.tabBarFavoritesSelectImage)
        )
        return view
    }

    func makeProfileModule(coordinator: ProfileSceneCoordinator) -> ProfileViewController {
        let view = ProfileViewController()
        let presenter = ProfileViewPresenter(
            view: view,
            coordinator: coordinator
        )
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: Constants.profileTitle,
            image: UIImage(named: Constants.tabBarProfileUnselectImage),
            selectedImage: UIImage(named: Constants.tabBarProfileSelectImage)
        )
        return view
    }

    func makeBonusesModule(coordinator: ProfileSceneCoordinator) -> BonusesViewController {
        let view = BonusesViewController()
        let presenter = BonusesViewPresenter(
            view: view,
            coordinator: coordinator
        )
        view.presenter = presenter

        return view
    }
}
