// CategoryRecipeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран отображения  категории рецептов
final class CategoryRecipeViewController: UIViewController {
    // MARK: Public Properties

    var presenter: CategoryRecipeViewPresenter?

    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        ""
    }
}

// MARK: - CategoryRecipeViewProtocol

/// CategoryRecipeViewController + CategoryRecipeViewProtocol
extension CategoryRecipeViewController: CategoryRecipeViewProtocol {}
