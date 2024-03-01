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

        let button = UIButton()
        view.addSubview(button)
        button.frame = .init(x: 0, y: 0, width: 200, height: 200)
        button.center = view.center
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        presenter?.goToCategoryScreen(index: 1)
    }
}

// MARK: - RecipesViewProtocol

/// RecipesViewController + RecipesViewProtocol
extension RecipesViewController: RecipesViewProtocol {}
