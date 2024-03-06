// ProfileInfoTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Типы ячеек информации пользователя
enum ProfileInfoCellTypes: String {
    /// Тип ячейки для раздела бонусы
    case bonuses = "Bonuses"
    /// Тип ячейки для раздела соглашения  и приватная политика
    case terms = "Terms & Privacy Policy"
    /// Тип ячейки выход из профиля
    case logOut = "Log out"

    // Имя ячейки
    var imageName: String {
        switch self {
        case .bonuses:
            return "settingsProfileBonuses"
        case .terms:
            return "settingsProfileTerms"
        case .logOut:
            return "settingsProfileLogOut"
        }
    }
}

/// Ячейка для отображения данных профиля
final class ProfileInfoTableViewCell: UITableViewCell {
    // MARK: Constants

    private enum Constants {
        static let arrowImageName = "chevron.right"
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private let cellTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .systemGray6
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .addVerdana(withSize: 17)
        label.textColor = .gray
        return label
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: Constants.arrowImageName)
        imageView.tintColor = .gray
        return imageView
    }()

    // MARK: Private Properties

    private var cellType: ProfileInfoCellTypes?

    // MARK: Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupHierarchy()
        setupConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cellType = nil
        cellTypeImageView.image = nil
        titleLabel.text = nil
    }

    // MARK: Public methods

    func configureCell(cellType: ProfileInfoCellTypes) {
        self.cellType = cellType
        cellTypeImageView.image = UIImage(named: cellType.imageName)
        titleLabel.text = cellType.rawValue
    }

    // MARK: Private Methods

    private func setupView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        selectedBackgroundView = backgroundView
    }

    private func setupHierarchy() {
        [
            cellTypeImageView,
            titleLabel,
            arrowImageView
        ].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 68).isActive = true

        setupCellTypeImageViewConstraint()
        setupTitleLabelConstraint()
        setupArrowImageViewConstraint()
    }

    private func setupCellTypeImageViewConstraint() {
        NSLayoutConstraint.activate([
            cellTypeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellTypeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellTypeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            cellTypeImageView.widthAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func setupTitleLabelConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: cellTypeImageView.trailingAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }

    private func setupArrowImageViewConstraint() {
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            arrowImageView.heightAnchor.constraint(equalTo: arrowImageView.widthAnchor)
        ])
    }
}
