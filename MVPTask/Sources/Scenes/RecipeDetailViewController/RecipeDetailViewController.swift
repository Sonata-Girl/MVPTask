// RecipeDetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран отображения детализации рецепта
final class RecipeDetailViewController: UIViewController {

    // MARK: Constants

    enum Constants {
        static let screenDefaultTitle = "Category"
        static let backButtonImage = "tabBarBackButton"
        static let searchBarPlaceholder = "Search recipes"
        static let shareButtonImage = "paperplane"
        static let bookMarkImage = "bookmark"
        static let titleInDevelopmentAlert = "Functionality in development"
    }

    /// Секции таблицы
    private enum TableSections {
        /// Заголовок с картинкой
        case header
        /// Данные по содержанию КБЖУ
        case nutrients
        /// Детальное описание рецепта
        case description
    }

    // MARK: Visual Components

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Constants.backButtonImage), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(backToPreviousScreen), for: .touchUpInside)
        return button
    }()

    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.setImage(UIImage(systemName: Constants.shareButtonImage), for: .normal)
        button.addTarget(nil, action: #selector(shareRecipeDescription), for: .touchUpInside)
        return button
    }()

    private let addFavoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.setImage(UIImage(systemName: Constants.bookMarkImage), for: .normal)
        button.addTarget(nil, action: #selector(addFavoriteRecipe), for: .touchUpInside)
        return button
    }()

    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(HeaderRecipeViewCell.self, forCellReuseIdentifier: HeaderRecipeViewCell.identifier)
        tableView.register(NutrientsRecipeViewCell.self, forCellReuseIdentifier: NutrientsRecipeViewCell.identifier)
        tableView.register(RecipeDescriptionCell.self, forCellReuseIdentifier: RecipeDescriptionCell.identifier)
        tableView.dataSource = self
        return tableView
    }()

    // MARK: Public Properties

    var presenter: RecipeDetailViewPresenter?

    // MARK: Private Properties

    private let tableSections: [TableSections] = [.header, .nutrients, .description]

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Private Methods

    private func configureNavigationBar() {
        let barBackButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barBackButton

        let barShareButton = UIBarButtonItem(customView: shareButton)
        let barAddFavoriteButton = UIBarButtonItem(customView: addFavoriteButton)

        navigationItem.rightBarButtonItems = [barAddFavoriteButton, barShareButton]
    }

    private func setupHierarchy() {
        view.addSubview(mainTableView)
    }

    private func setupConstraints() {
        setupMainTableViewConstraint()
    }

    private func setupMainTableViewConstraint() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func showAlertAboutFunctionality() {
        showAlert(
            title: Constants.titleInDevelopmentAlert,
            hasCancel: false
        )
    }

    @objc private func shareRecipeDescription() {
        guard let recipe = presenter?.recipe else { return }
        let shareController = UIActivityViewController(
            activityItems: [recipe.detailDescription],
            applicationActivities: nil
        )
        present(shareController, animated: true)
    }

    @objc private func addFavoriteRecipe() {
        showAlertAboutFunctionality()
    }

    @objc private func backToPreviousScreen() {
        presenter?.backToCategoryScreen()
    }
}

// MARK: - UITableViewDataSource

/// RecipeDetailViewController + UITableViewDataSource
extension RecipeDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipe = presenter?.recipe else { return UITableViewCell() }
        switch tableSections[indexPath.section] {
        case .header:
            let cell = getHeaderCell(tableView)
            cell.configureCell(recipe: recipe)
            return cell
        case .nutrients:
            let cell = getNutrientsCell(tableView)
            cell.configureCell(recipe: recipe)
            return cell
        case .description:
            let cell = getDescriptionCell(tableView)
            cell.configureCell(recipe: recipe)
            return cell
        }
    }

    private func getHeaderCell(_ tableView: UITableView) -> HeaderRecipeViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderRecipeViewCell.identifier)
            as? HeaderRecipeViewCell
        else { return HeaderRecipeViewCell() }
        return cell
    }

    private func getNutrientsCell(_ tableView: UITableView) -> NutrientsRecipeViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NutrientsRecipeViewCell.identifier)
            as? NutrientsRecipeViewCell
        else { return NutrientsRecipeViewCell() }
        return cell
    }

    private func getDescriptionCell(_ tableView: UITableView) -> RecipeDescriptionCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeDescriptionCell.identifier
            ) as? RecipeDescriptionCell
        else { return RecipeDescriptionCell() }
        return cell
    }
}

// MARK: - RecipeDetailViewProtocol

/// RecipeDetailViewController + RecipeDetailViewProtocol
extension RecipeDetailViewController: RecipeDetailViewProtocol {}
