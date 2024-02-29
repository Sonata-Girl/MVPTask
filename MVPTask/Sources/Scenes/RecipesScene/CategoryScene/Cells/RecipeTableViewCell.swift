// RecipeTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения рецетов
final class RecipeTableViewCell: UITableViewCell {
    // MARK: Constants

    private enum Constants {
        static let arrowImageName = "rightChevron"
        static let pizzaImageName = "pizzaIcon"
        static let timerImageName = "timerIcon"
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    private lazy var recipeNameLabel: UILabel = {
        let label = makeLabel()
        label.font = .setVerdana(withSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private lazy var timerImageView: UIImageView = {
        let imageView = makeImageView()
        imageView.image = UIImage(systemName: Constants.timerImageName)
        return imageView
    }()

    private lazy var timerLabel: UILabel = makeLabel()

    private lazy var caloriesImageView: UIImageView = {
        let imageView = makeImageView()
        imageView.image = UIImage(systemName: Constants.pizzaImageName)
        return imageView
    }()

    private lazy var caloriesLabel: UILabel = makeLabel()

    private lazy var arrowButton: UIImageView = {
        let imageView = makeImageView()
        imageView.image = UIImage(named: Constants.arrowImageName)
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
        ""
//        cellType = nil
//        cellTypeImageView.image = nil
//        titleLabel.text = nil
    }

    // MARK: Public methods

    func configureCell(cellType: ProfileInfoCellTypes) {
//        self.cellType = cellType
//        cellTypeImageView.image = UIImage(named: cellType.imageName)
//        titleLabel.text = cellType.rawValue
    }

    // MARK: Private Methods

    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        return imageView
    }

    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 12)
        label.textColor = .gray
        return label
    }

    private func setupView() {
        contentView.backgroundColor = UIColor().appLightMint

        let backgroundView = UIView()
        backgroundView.backgroundColor = contentView.backgroundColor
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor().appMint?.cgColor
        selectedBackgroundView = backgroundView
    }

    private func setupHierarchy() {
//        [
//            cellTypeImageView,
//            titleLabel,
//            arrowImageView
//        ].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 68).isActive = true

        setupCellTypeImageViewConstraint()
        setupTitleLabelConstraint()
        setupArrowImageViewConstraint()
    }

    private func setupCellTypeImageViewConstraint() {
//        NSLayoutConstraint.activate([
//            cellTypeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            cellTypeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            cellTypeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
//            cellTypeImageView.widthAnchor.constraint(equalToConstant: 48)
//        ])
    }

    private func setupTitleLabelConstraint() {
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            titleLabel.leadingAnchor.constraint(equalTo: cellTypeImageView.trailingAnchor, constant: 10),
//            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
//        ])
    }

    private func setupArrowImageViewConstraint() {
//        NSLayoutConstraint.activate([
//            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
//            arrowImageView.heightAnchor.constraint(equalTo: arrowImageView.widthAnchor)
//        ])
    }
}
