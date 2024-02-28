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
        tableView.separatorStyle = .none
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

    private let imagePicker = ImagePicker()

    // MARK: Public Properties

    var presenter: ProfileViewPresenterProtocol?

    // MARK: Private Properties

    private var tableSections: [TableSections] = [.profileHeader, .profileInfo]

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        setupHierarchy()
        setupConstraints()
    }

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
            profileTableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 25
            ),
            profileTableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -25
            ),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func showChangeNameAlert() {
        presenter?.showChangeNameInputAlert()
    }

    private func showChangeAvatarPicker() {
        imagePicker.showImagePicker(in: self) { image in
            let cell = self.profileTableView.cellForRow(
                at: IndexPath(row: 0, section: 0)
            ) as? ProfileHeaderTableViewCell
            cell?.changeAvatar(image: image)
        }
    }
}

// MARK: - UITableViewDataSource

/// ProfileViewController + UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter else { return 0 }
        switch tableSections[section] {
        case .profileHeader:
            return 1
        case .profileInfo:
            return presenter.profileInfoCellTypes.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter else { return UITableViewCell() }
        switch tableSections[indexPath.section] {
        case .profileHeader:
            guard let user = presenter.user,
                  let cell = tableView.dequeueReusableCell(
                      withIdentifier: ProfileHeaderTableViewCell.identifier,
                      for: indexPath
                  ) as? ProfileHeaderTableViewCell
            else { return UITableViewCell() }
            cell.configureCell(
                imageName: user.imageName,
                userName: "\(user.surname) \(user.name)"
            )
            cell.nameChangeHandler = { [weak self] in
                self?.showChangeNameAlert()
            }
            cell.avatarChangeHandler = { [weak self] in
                self?.showChangeAvatarPicker()
            }
            return cell
        case .profileInfo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileInfoTableViewCell.identifier,
                for: indexPath
            ) as? ProfileInfoTableViewCell
            else { return UITableViewCell() }
            cell.configureCell(cellType: presenter.profileInfoCellTypes[indexPath.row])
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

/// ProfileViewController + UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case .profileInfo = tableSections[indexPath.section] {
            guard let presenter else { return }
            switch presenter.profileInfoCellTypes[indexPath.row] {
            case .bonuses:
                presenter.showBonusesScreen()
            case .logOut:
                presenter.showLogOutAlert()
            case .terms:
                presenter.showTermsAlert()
            }
        }
    }
}

// MARK: - ProfileViewProtocol

/// ProfileViewController + ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
    func reloadHeaderProfile() {
        profileTableView.reloadRows(at: [IndexPath.SubSequence(row: 0, section: 0)], with: .none)
    }
}
