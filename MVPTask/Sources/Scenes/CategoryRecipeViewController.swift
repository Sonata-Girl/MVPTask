// CategoryRecipeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран отображения  категории рецептов
final class CategoryRecipeViewController: UIViewController {
    // MARK: Constants

    enum Constants {
        static let screenDefaultTitle = "Category"
        static let backButtonImage = "tabBarBackButton"
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

    private lazy var mainTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(
            SortButtonsTableHeaderView.self,
            forHeaderFooterViewReuseIdentifier: SortButtonsTableHeaderView.identifier
        )
        tableView.register(
            RecipeTableViewCell.self,
            forCellReuseIdentifier: RecipeTableViewCell.identifier
        )
        /// регистрация моей ячейки "ShimmerCellView"
        tableView.register(ShimmerCellView.self, forCellReuseIdentifier: "ShimmerCellView")
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    // MARK: Public Properties

    var presenter: CategoryRecipeViewPresenterProtocol?

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Public methods

    func setTitle(title: String) {
        backButton.setTitle(title, for: .normal)
    }

    // MARK: Private Methods

    private func configureNavigationBar() {
        let barBackButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barBackButton
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func configureView() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        [
            mainTableView,
            searchBar
        ].forEach { view.addSubview($0) }
    }

    private func setupConstraints() {
        setupMainTableViewConstraint()
        setupSearchBarConstraint()
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

    private func setupMainTableViewConstraint() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: mainTableView.bottomAnchor),
        ])
    }

    @objc private func backToPreviousScreen() {
        presenter?.backToRecipeScreen()
    }
}

// MARK: - CategoryRecipeViewProtocol

/// CategoryRecipeViewController + CategoryRecipeViewProtocol
extension CategoryRecipeViewController: CategoryRecipeViewProtocol {}

// MARK: - UISearchBarDelegate

/// CategoryRecipeViewController + UISearchBarDelegate
extension CategoryRecipeViewController: UISearchBarDelegate {}

// MARK: - UITableViewDataSource

/// CategoryRecipeViewController + UITableViewDataSource
extension CategoryRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter else { return 0 }
        return presenter.getRecipes().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter,
              let cell = tableView.dequeueReusableCell(
                  withIdentifier: RecipeTableViewCell.identifier
              ) as? RecipeTableViewCell
        else { return UITableViewCell() }
        cell.configureCell(recipe: presenter.getRecipes()[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

/// CategoryRecipeViewController + UITableViewDelegate
extension CategoryRecipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let header = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: SortButtonsTableHeaderView.identifier
            ) as? SortButtonsTableHeaderView
        else { return UITableViewHeaderFooterView() }
        header.delegate = self
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell else { return }
        cell.selectCell()
        presenter?.goToDetailRecipeScreen(index: indexPath.row)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            cell.setupUnselectState()
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell else { return }
        cell.selectCell()
    }
}

// MARK: - FiltersTableHeaderViewDelegate

/// CategoryRecipeViewController + FiltersTableHeaderViewDelegate
extension CategoryRecipeViewController: SortButtonsTableHeaderViewDelegate {
    // TODO: Будет доработка
    /// Произошло изменение состояния сортировки по пришедшему виду сортировки
    func sortButtonsView(with stateSortButton: SortButtonState, didChangeSortTo sortType: SortType) {
        print("sortButtonsView didChangeSortTo \(sortType)")
    }
}
