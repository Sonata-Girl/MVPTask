// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран отображения  рецептов
final class RecipesViewController: UIViewController {
    // MARK: Public Properties

    var presenter: RecipesViewPresenter?

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        ""
    }
}

// MARK: - RecipesViewProtocol

/// RecipesViewController + RecipesViewProtocol
extension RecipesViewController: RecipesViewProtocol {}
