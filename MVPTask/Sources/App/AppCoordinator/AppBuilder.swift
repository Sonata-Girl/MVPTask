// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol AppBuilderProtocol {
    func createRecipesModule() -> UIViewController
    func createFavoritesModule() -> UIViewController
    func createProfileModule() -> ProfileViewController
}

final class AppBuilder {
    // MARK: Constants

    enum Constants {
        static let recipesTitle = "Recipes"
        static let favoritesTitle = "Favorites"
        static let profileTitle = "Profile"
    }

    func createRecipesModule() -> UIViewController {
        let view = UIViewController()

        view.tabBarItem = UITabBarItem(
            title: Constants.recipesTitle,
            image: .tabBarRecipesUnselect,
            selectedImage: .tabBarRecipesSelect
        )
        return view
    }

    func createFavoritesModule() -> UIViewController {
        let view = UIViewController()

        view.tabBarItem = UITabBarItem(
            title: Constants.recipesTitle,
            image: .tabBatFavoritesUnselect,
            selectedImage: .tabBarFavoritesSelect
        )
        return view
    }

    func createProfileModule() -> ProfileViewController {
        let view = ProfileViewController()
        let presenter = ProfileViewPresenter(view: view)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: Constants.profileTitle,
            image: .tabBarProfileUnselect,
            selectedImage: .tabBarProfileSelect
        )
        return view
    }
}
