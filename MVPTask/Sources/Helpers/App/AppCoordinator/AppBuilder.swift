// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол билдера приложения
protocol AppBuilderProtocol {
    /// Создание модуля экрана авторизации
    func createLoginModule() -> LoginViewController
    /// Создание модуля экрана рецептов (1 экран таббара)
    func createRecipesModule() -> UIViewController
    /// Создание модуля экрана избранных  (2 экран таббара)
    func createFavoritesModule() -> UIViewController
    /// Создание модуля экрана профиля  (3 экран таббара)
    func createProfileModule() -> ProfileViewController
}

/// Общий билдер приложения
final class AppBuilder {
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

    func createLoginModule() -> LoginViewController {
        let view = LoginViewController()
        let presenter = LoginViewPresenter(view: view)
        view.presenter = presenter

        return view
    }

    func createRecipesModule() -> UIViewController {
        let view = UIViewController()

        view.tabBarItem = UITabBarItem(
            title: Constants.recipesTitle,
            image: UIImage(named: Constants.tabBarRecipesUnselectImage),
            selectedImage: UIImage(named: Constants.tabBarRecipesSelectImage)
        )
        return view
    }

    func createFavoritesModule() -> UIViewController {
        let view = UIViewController()

        view.tabBarItem = UITabBarItem(
            title: Constants.recipesTitle,
            image: UIImage(named: Constants.tabBatFavoritesUnselectImage),
            selectedImage: UIImage(named: Constants.tabBarFavoritesSelectImage)
        )
        return view
    }

    func createProfileModule() -> ProfileViewController {
        let view = ProfileViewController()
        let presenter = ProfileViewPresenter(view: view)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: Constants.profileTitle,
            image: UIImage(named: Constants.tabBarProfileUnselectImage),
            selectedImage: UIImage(named: Constants.tabBarProfileSelectImage)
        )
        return view
    }

    func createBonusesModule() -> BonusesViewController {
        let view = BonusesViewController()
        let presenter = BonusesViewPresenter(view: view)
        view.presenter = presenter

        return view
    }
}
