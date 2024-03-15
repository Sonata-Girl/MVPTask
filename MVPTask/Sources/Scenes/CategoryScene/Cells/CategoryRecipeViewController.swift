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
        button.titleLabel?.font = UIFont.addVerdanaBold(withSize: 28)
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
        tableView.register(
            ErrorPlaceholderViewCell.self,
            forCellReuseIdentifier: ErrorPlaceholderViewCell.identifier
        )
        tableView.register(
            NoDataPlaceholderViewCell.self,
            forCellReuseIdentifier: NoDataPlaceholderViewCell.identifier
        )
        tableView.register(ShimmerCellView.self, forCellReuseIdentifier: "ShimmerCellView")
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    private lazy var refreshTableControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        return refreshControl
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

        presenter?.loadRecipes(refresh: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.logTransition()
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

        mainTableView.addSubview(refreshTableControl)
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

    private func showErrorAlert(error: String) {
        showAlert(title: error, hasCancel: false)
    }

    @objc private func backToPreviousScreen() {
        presenter?.backToRecipeScreen()
    }

    @objc private func refreshTableView() {
        presenter?.loadRecipes(refresh: true)
    }
}

// MARK: - CategoryRecipeViewProtocol

/// CategoryRecipeViewController + CategoryRecipeViewProtocol
extension CategoryRecipeViewController: CategoryRecipeViewProtocol {
    func reloadTable() {
        mainTableView.reloadData()
    }

    func loadImageInCell(indexCell: Int, imageBase64: String) {
        if let cell = mainTableView.cellForRow(at: IndexPath(item: indexCell, section: 0)) as? RecipeTableViewCell {
            cell.setupImage(imageBase64: imageBase64)
        }
    }

    func stopRefreshing() {
        refreshTableControl.endRefreshing()
    }
}

// MARK: - UISearchBarDelegate

/// CategoryRecipeViewController + UISearchBarDelegate
extension CategoryRecipeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.search(searchText: searchText)
    }
}

// MARK: - UITableViewDataSource

/// CategoryRecipeViewController + UITableViewDataSource
extension CategoryRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch presenter?.state {
        case .loading:
            return 10
        case let .data(recipes):
            return recipes.count
        case .error, .noData:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter else { return UITableViewCell() }
        switch presenter.state {
        case .loading:
            return getShimmerCell(tableView)
        case let .data(recipes):
            return getRecipeCell(tableView, recipes: recipes, indexPath: indexPath)
        case .error:
            return getErrorCell(tableView)
        case .noData:
            return getNoDataCell(tableView)
        }
    }

    private func getRecipeCell(_ tableView: UITableView, recipes: [Recipe], indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RecipeTableViewCell.identifier
        ) as? RecipeTableViewCell
        else { return UITableViewCell() }
        let recipe = recipes[indexPath.row]
        cell.configureCell(recipe: recipe)
        if recipe.imageBase64.isEmpty {
            presenter?.loadImage(indexCell: indexPath.row)
        }
        return cell
    }

    private func getShimmerCell(_ tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ShimmerCellView.identifier
        ) as? ShimmerCellView
        else { return UITableViewCell() }
        cell.startShimmers()
        return cell
    }

    private func getErrorCell(_ tableView: UITableView) -> ErrorPlaceholderViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ErrorPlaceholderViewCell.identifier)
            as? ErrorPlaceholderViewCell
        else { return ErrorPlaceholderViewCell() }
        cell.reloadButtonHandler = { [weak self] in
            self?.presenter?.loadRecipes(refresh: false)
        }
        cell.setupLessSize()
        return cell
    }

    private func getNoDataCell(_ tableView: UITableView) -> NoDataPlaceholderViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoDataPlaceholderViewCell.identifier)
            as? NoDataPlaceholderViewCell
        else { return NoDataPlaceholderViewCell() }
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
    /// Произошло изменение состояния сортировки по пришедшему виду сортировки
    func sortButtonsView(with stateSortButton: SortButtonState, didChangeSortTo sortType: SortType) {
        presenter?.changeSort(sortType: sortType, stateSort: stateSortButton)
    }
}
