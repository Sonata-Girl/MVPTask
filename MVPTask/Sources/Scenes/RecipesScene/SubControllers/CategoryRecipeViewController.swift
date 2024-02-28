// CategoryRecipeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран отображения  категории рецептов
final class CategoryRecipeViewController: UIViewController {
    // MARK: Types

    // MARK: Constants

    enum Constants {
        static let screenDefaultTitle = "Category"
        static let backButtonImage = "arrow.left"
        static let caloriesFilterTitle = "Calories"
        static let timeFilterTitle = "Time"
    }

    // MARK: Visual Components

    private let titleScreenLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 28)
        label.text = Constants.screenDefaultTitle
        return label
    }()

    private let searchController: UISearchController = {
        let searchController = UISearchController()
        return searchController
    }()

    private lazy var filterButtonsView: FilterView = {
        let view = FilterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        return view
    }()

    // MARK: Public Properties

    var presenter: CategoryRecipeViewPresenter?

    // MARK: Private Properties

    private let filterButtonsSource = [
        Constants.caloriesFilterTitle,
        Constants.timeFilterTitle
    ]

    // MARK: Initializers

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Public methods

    // MARK: Private Methods

    private func configureNavigationBar() {
        navigationItem.searchController = searchController
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.backButtonImage)
        imageView.tintColor = .label
        let barBackButton = UIBarButtonItem(customView: imageView)
        let titleView = UIBarButtonItem(customView: titleScreenLabel)
        navigationItem.leftBarButtonItems = [barBackButton, titleView]
    }

    private func configureView() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(filterButtonsView)
//        contentView.addSubview(nameLabel)
    }

    private func setupConstraints() {
        setupFilterButtonsViewConstraint()
//        setupNameLabelConstraint()
//        setupEditNameButtonConstraint()
    }

    private func setupFilterButtonsViewConstraint() {
        NSLayoutConstraint.activate([
            filterButtonsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            filterButtonsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: filterButtonsView.trailingAnchor, constant: 10),
            filterButtonsView.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    // MARK: - IBAction или @objc (private)
}

// MARK: - CategoryRecipeViewProtocol

/// CategoryRecipeViewController + CategoryRecipeViewProtocol
extension CategoryRecipeViewController: CategoryRecipeViewProtocol {}

// MARK: - FilterViewDataSource

/// CategoryRecipeViewController + FilterViewDataSource
extension CategoryRecipeViewController: FilterViewDataSource {
    func filterViewCount(_ filterView: FilterView) -> Int {
        filterButtonsSource.count
    }

    func filterViewTitle(_ filterView: FilterView, indexPath: IndexPath) -> String {
        filterButtonsSource[indexPath.row]
    }
}
