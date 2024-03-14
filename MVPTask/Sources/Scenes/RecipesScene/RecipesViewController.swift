// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран отображения  рецептов
final class RecipesViewController: UIViewController {
    // MARK: Visual Components

    private var collectionView: UICollectionView!
    private let collectionViewLayout = UICollectionViewFlowLayout()

    // MARK: Public Properties

    var presenter: RecipesViewPresenter?

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addView()
        addConstraints()
        title = "Recipes"
        navigationController?.navigationBar.prefersLargeTitles = true

        presenter?.loadRecipes()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.logTransition()
    }

    // MARK: Private Methods

    private func addView() {
        view.addSubview(collectionView)
    }

    private func addConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            RecipeCellColectionView.self,
            forCellWithReuseIdentifier: "RecipeCellColectionView"
        )
        collectionView.register(
            ShimmerRecipeViewCell.self,
            forCellWithReuseIdentifier: ShimmerRecipeViewCell.identifier
        )
    }

    private func showErrorAlert(error: String) {
        showAlert(title: error, hasCancel: false)
    }
}

// MARK: - RecipesViewProtocol

/// RecipesViewController + RecipesViewProtocol
extension RecipesViewController: RecipesViewProtocol {
    func reloadTable() {
        collectionView.reloadData()
    }
}

// MARK: - Extension + UICollectionViewDataSource

extension RecipesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch presenter?.state {
        case let .data(categories):
            return categories.count
        case .loading:
            return 10
        default:
            return 0
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let presenter else { return UICollectionViewCell() }
        switch presenter.state {
        case let .data(categories):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "RecipeCellColectionView",
                for: indexPath
            ) as? RecipeCellColectionView else { return UICollectionViewCell() }
            cell.configureCell(param: categories[indexPath.item])
            return cell
        case .loading:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ShimmerRecipeViewCell.identifier,
                for: indexPath
            ) as? ShimmerRecipeViewCell else { return UICollectionViewCell() }
            cell.setupShimmers()
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - Extension + UICollectionViewDelegateFlowLayout

extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var cellSize = CGFloat()
        let cellNumber = indexPath.item % 7

        switch cellNumber {
        case 0, 1:
            cellSize = (view.frame.width - 30) / 2
        case 2, 6:
            cellSize = view.frame.width - 140
        case 3 ... 5:
            cellSize = (view.frame.width - 40) / 3
        default:
            cellSize = 10
        }
        return CGSize(width: cellSize, height: cellSize)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        10.0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        9
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension RecipesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter else { return }
        presenter.goToCategoryScreen(index: indexPath.item)
    }
}
