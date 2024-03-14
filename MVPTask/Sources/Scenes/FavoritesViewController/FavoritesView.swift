// FavoritesView.swift
// Copyright © RoadMap. All rights reserved.

//
//  FavoritesViewController.swift
//  MVPTask
//
//  Created by Алексей Барлетов on 03.03.2024.
//
///
import UIKit

/// Протокол  экрана избранное
protocol FavoritesViewProtocol: AnyObject {
    func showView(element: Bool)
}

/// Класс для отображения избранного
class FavoritesView: UIViewController {
    // MARK: Public Property

    var presenter: FavoritesPresenterProtocol?

    // MARK: Private Property

    private var copyMainScreenView = FavoritesPlaceholderView()

    private var tableView = UITableView()
    private var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Favorites"
        label.font = .addVerdanaBold(withSize: 28)
        label.textColor = .black
        return label
    }()

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = .white
        copyMainScreenView.isHidden = true
        view.addSubview(copyMainScreenView)
        setNavigationItem()
    }

    private func setNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getRecipes()
    }

    // MARK: Private Methode

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.identifier)
    }
}

// MARK: Extension + FavoritesViewProtocol

extension FavoritesView: FavoritesViewProtocol {
    func showView(element: Bool) {
        copyMainScreenView.isHidden = element
    }
}

// MARK: Extension + UITableViewDataSource

extension FavoritesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getRecipes().count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter,
              let cell = tableView.dequeueReusableCell(
                  withIdentifier: FavoritesCell.identifier
              ) as? FavoritesCell
        else { return UITableViewCell() }
        cell.configureCell(recipe: presenter.getRecipes()[indexPath.row])
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        presenter?.deleteElement(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        presenter?.examinationEmptyElement()
    }
}
