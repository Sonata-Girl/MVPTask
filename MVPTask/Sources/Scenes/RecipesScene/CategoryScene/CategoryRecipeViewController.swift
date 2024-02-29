// CategoryRecipeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран отображения  категории рецептов
final class CategoryRecipeViewController: UIViewController {
    // MARK: Types

    // MARK: Constants

    enum Constants {
        static let screenDefaultTitle = "Category"
        static let backButtonImage = "tabBarBackButton"
        static let caloriesFilterTitle = "Calories"
        static let timeFilterTitle = "Time"
        static let searchBarPlaceholder = "Search recipes"
    }

    // MARK: Visual Components

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.backButtonImage), for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.setTitle(Constants.screenDefaultTitle, for: .normal)
        button.titleLabel?.font = UIFont.setVerdanaBold(withSize: 28)
        button.tintColor = .label
        button.addTarget(self, action: #selector(backToPreviousScreen), for: .touchUpInside)
        return button
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Constants.searchBarPlaceholder
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.backgroundColor = UIColor().appLightGray
        searchBar.showsCancelButton = false
        searchBar.sizeToFit()
        return searchBar
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
        let barBackButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barBackButton
    }

    private func configureView() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(filterButtonsView)
    }

    private func setupConstraints() {
        setupSearchBarConstraint()
        setupFilterButtonsViewConstraint()
//        setupEditNameButtonConstraint()
    }

    private func setupSearchBarConstraint() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            searchBar.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 10
            ),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: searchBar.trailingAnchor,
                constant: 10
            ),
            searchBar.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    private func setupFilterButtonsViewConstraint() {
        NSLayoutConstraint.activate([
            filterButtonsView.topAnchor.constraint(
                equalTo: searchBar.bottomAnchor,
                constant: 10
            ),
            filterButtonsView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            filterButtonsView.heightAnchor.constraint(equalToConstant: 56),
            filterButtonsView.widthAnchor.constraint(equalToConstant: 230)
        ])
    }

    @objc private func backToPreviousScreen() {
        presenter?.backToRecipeScreen()
    }
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

// MARK: - UISearchBarDelegate

/// CategoryRecipeViewController + UISearchBarDelegate
extension CategoryRecipeViewController: UISearchBarDelegate {}
