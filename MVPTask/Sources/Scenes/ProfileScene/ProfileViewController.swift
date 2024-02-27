// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля пользователя
final class ProfileViewController: UIViewController {
    // MARK: Types

    private enum TableSections {
        case profileHeader
        case profileInfo
    }

    // MARK: Constants

    enum Constants {
        static let screenTitle = "Profile"
    }

    // MARK: Visual Components

    private let screenTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.screenTitle
        label.font = .setVerdanaBold(withSize: 28)
        label.textColor = .label
        return label
    }()

    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.allowsSelection = false // отключение возможности выбора
        tableView.register(
            ProfileHeaderTableViewCell.self,
            forCellReuseIdentifier: ProfileHeaderTableViewCell.identifier
        )
        tableView.register(
            ProfileInfoTableViewCell.self,
            forCellReuseIdentifier: ProfileInfoTableViewCell.identifier
        )

        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // MARK: Public Properties

    var presenter: ProfileViewPresenter?

    // MARK: Private Properties

    private var tableSections: [TableSections] = [.profileHeader, .profileInfo]
    private var profileInfoCellTypes: [ProfileInfoCellTypes] = [.bonuses, .terms, .logOut]

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

    // MARK: IBAction или @objc (not private)

    // MARK: Private Methods

    private func configureNavigationBar() {
        let buttonBar = UIBarButtonItem(customView: screenTitleLabel)
        navigationItem.leftBarButtonItem = buttonBar
    }

    private func configureView() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(profileTableView)
    }

    private func setupConstraints() {
        setupProfileTableViewConstraint()
    }

    private func setupProfileTableViewConstraint() {
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDataSource

/// ProfileViewController + UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableSections[section] {
        case .profileHeader:
            return 1
        case .profileInfo:
            return profileInfoCellTypes.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableSections[indexPath.section] {
        case .profileHeader:
            guard let user = presenter?.user,
                  let cell = tableView.dequeueReusableCell(
                      withIdentifier: ProfileHeaderTableViewCell.identifier,
                      for: indexPath
                  ) as? ProfileHeaderTableViewCell
            else { return UITableViewCell() }
            cell.configureCell(
                imageName: user.imageName,
                userName: "\(user.surname) \(user.name)"
            )
            return cell
        case .profileInfo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileInfoTableViewCell.identifier,
                for: indexPath
            ) as? ProfileInfoTableViewCell
            else { return UITableViewCell() }
            cell.configureCell(cellType: profileInfoCellTypes[indexPath.row])
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

/// ProfileViewController + UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
}
