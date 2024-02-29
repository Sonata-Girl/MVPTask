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
        contentView.layer.cornerRadius = 10

        let backgroundView = UIView()
        backgroundView.backgroundColor = contentView.backgroundColor
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor().appMint?.cgColor
        selectedBackgroundView = backgroundView
    }

    private func setupHierarchy() {
        [
            recipeImageView,
            recipeNameLabel,
            timerImageView,
            timerLabel,
            caloriesImageView,
            caloriesLabel,
            arrowButton
        ].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        setupRecipeImageViewConstraint()
        setupRecipeNameLabelConstraint()
        setupTimerImageViewConstraint()
        setupTimerLabelConstraint()
        setupCaloriesImageViewConstraint()
        setupCaloriesLabelConstraint()
        setupArrowButtonConstraint()
    }

    private func setupRecipeImageViewConstraint() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            recipeImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setupRecipeNameLabelConstraint() {
        NSLayoutConstraint.activate([
            recipeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            recipeNameLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20),
            recipeNameLabel.widthAnchor.constraint(equalToConstant: 197),
            recipeNameLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    private func setupTimerImageViewConstraint() {
        NSLayoutConstraint.activate([
            timerImageView.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 10),
            timerImageView.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20),
            timerImageView.widthAnchor.constraint(equalToConstant: 15),
            timerImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupTimerLabelConstraint() {
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 10),
            timerLabel.leadingAnchor.constraint(equalTo: timerImageView.trailingAnchor, constant: 4),
            timerLabel.widthAnchor.constraint(equalToConstant: 60),
            timerLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupCaloriesImageViewConstraint() {
        NSLayoutConstraint.activate([
            caloriesImageView.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 10),
            caloriesImageView.leadingAnchor.constraint(equalTo: timerImageView.trailingAnchor, constant: 8),
            caloriesImageView.widthAnchor.constraint(equalToConstant: 15),
            caloriesImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupCaloriesLabelConstraint() {
        NSLayoutConstraint.activate([
            caloriesLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 10),
            caloriesLabel.leadingAnchor.constraint(equalTo: caloriesImageView.trailingAnchor, constant: 4),
            caloriesLabel.widthAnchor.constraint(equalToConstant: 70),
            caloriesLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupArrowButtonConstraint() {
        NSLayoutConstraint.activate([
            arrowButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: contentView.leadingAnchor),
            arrowButton.widthAnchor.constraint(equalToConstant: 40),
            arrowButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
