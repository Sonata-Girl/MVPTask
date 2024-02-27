// MainTabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таббар приложения, разделение на основные экраны
final class MainTabBarController: UITabBarController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }

    // MARK: Private methods

    private func setupTabBarController() {
        view.backgroundColor = .white
        tabBar.isTranslucent = false
        tabBar.tintColor = .appMint
    }
}
