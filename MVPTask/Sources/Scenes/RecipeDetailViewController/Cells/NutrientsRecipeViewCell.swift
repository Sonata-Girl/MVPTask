// NutrientsRecipeViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения информации кбжу рецепта
final class NutrientsRecipeViewCell: UITableViewCell {
    // MARK: Constants

    private enum Constants {
        static let gramText = "g"
        static let enercCaloriesTitle = "Enerc kcal"
        static let enercCaloriesText = " kcal"
        static let carbohydratesTitle = "Carbohydrates"
        static let fatsTitle = "Fats"
        static let proteinsTitle = "Proteins"
        static let appMintColor = UIColor().appMint ?? UIColor()
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private lazy var enercCaloriesView = makeView()

    private lazy var enercCaloriesLabel = makeLabel(
        textColor: .white,
        text: Constants.enercCaloriesTitle
    )

    private lazy var enercCaloriesCountLabel = makeLabel(textColor: Constants.appMintColor)

    private lazy var carbohydratesView = makeView()

    private lazy var carbohydratesLabel = makeLabel(
        textColor: .white,
        text: Constants.carbohydratesTitle
    )

    private lazy var carbohydratesCountLabel = makeLabel(textColor: Constants.appMintColor)

    private lazy var fatsView = makeView()

    private lazy var fatsLabel = makeLabel(
        textColor: .white,
        text: Constants.fatsTitle
    )

    private lazy var fatsCountLabel = makeLabel(textColor: Constants.appMintColor)

    private lazy var proteinsView = makeView()

    private lazy var proteinsLabel = makeLabel(
        textColor: .white,
        text: Constants.proteinsTitle
    )

    private lazy var proteinsCountLabel = makeLabel(textColor: Constants.appMintColor)

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
        enercCaloriesCountLabel.text = nil
        carbohydratesCountLabel.text = nil
        fatsCountLabel.text = nil
        proteinsCountLabel.text = nil
    }

    // MARK: Public methods

    func configureCell(recipe: Recipe) {
        enercCaloriesCountLabel.text = "\(recipe.enercKcal) \(Constants.enercCaloriesText)"
        carbohydratesCountLabel.text = "\(recipe.carbohydratesGram) \(Constants.gramText)"
        fatsCountLabel.text = "\(recipe.fatsGram) \(Constants.gramText)"
        proteinsCountLabel.text = "\(recipe.proteinGram) \(Constants.gramText)"
    }

    // MARK: Private Methods

    private func setupView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        selectedBackgroundView = backgroundView
    }

    private func setupHierarchy() {
        [
            enercCaloriesView,
            carbohydratesView,
            fatsView,
            proteinsView
        ].forEach { contentView.addSubview($0) }

        [
            enercCaloriesLabel,
            enercCaloriesCountLabel
        ].forEach { enercCaloriesView.addSubview($0) }

        [
            carbohydratesLabel,
            carbohydratesCountLabel
        ].forEach { carbohydratesView.addSubview($0) }

        [
            fatsLabel,
            fatsCountLabel
        ].forEach { fatsView.addSubview($0) }

        [
            proteinsLabel,
            proteinsCountLabel
        ].forEach { proteinsView.addSubview($0) }
    }

    private func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 73).isActive = true

        setupEnercCaloriesViewConstraint()
        setupCarbohydratesViewConstraint()
        setupFatsViewConstraint()
        setupProteinsViewConstraint()
    }

    private func setupEnercCaloriesViewConstraint() {
        NSLayoutConstraint.activate([
            enercCaloriesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            enercCaloriesView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            enercCaloriesView.heightAnchor.constraint(equalToConstant: 53),
            enercCaloriesView.widthAnchor.constraint(equalToConstant: 74)
        ])

        NSLayoutConstraint.activate([
            enercCaloriesLabel.topAnchor.constraint(equalTo: enercCaloriesView.topAnchor),
            enercCaloriesLabel.leadingAnchor.constraint(equalTo: enercCaloriesView.leadingAnchor),
            enercCaloriesLabel.trailingAnchor.constraint(equalTo: enercCaloriesView.trailingAnchor),
            enercCaloriesLabel.heightAnchor.constraint(equalToConstant: 31),
        ])

        NSLayoutConstraint.activate([
            enercCaloriesCountLabel.topAnchor.constraint(equalTo: enercCaloriesLabel.bottomAnchor),
            enercCaloriesCountLabel.leadingAnchor.constraint(equalTo: enercCaloriesView.leadingAnchor),
            enercCaloriesCountLabel.trailingAnchor.constraint(equalTo: enercCaloriesView.trailingAnchor),
            enercCaloriesCountLabel.bottomAnchor.constraint(equalTo: enercCaloriesView.bottomAnchor),
        ])
    }

    private func setupCarbohydratesViewConstraint() {
        NSLayoutConstraint.activate([
            carbohydratesView.leadingAnchor.constraint(equalTo: enercCaloriesView.trailingAnchor, constant: 5),
            carbohydratesView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            carbohydratesView.heightAnchor.constraint(equalToConstant: 53),
            carbohydratesView.widthAnchor.constraint(equalToConstant: 74)
        ])

        NSLayoutConstraint.activate([
            carbohydratesLabel.topAnchor.constraint(equalTo: carbohydratesView.topAnchor),
            carbohydratesLabel.leadingAnchor.constraint(equalTo: carbohydratesView.leadingAnchor),
            carbohydratesLabel.trailingAnchor.constraint(equalTo: carbohydratesView.trailingAnchor),
            carbohydratesLabel.heightAnchor.constraint(equalToConstant: 31),
        ])

        NSLayoutConstraint.activate([
            carbohydratesCountLabel.topAnchor.constraint(equalTo: carbohydratesLabel.bottomAnchor),
            carbohydratesCountLabel.leadingAnchor.constraint(equalTo: carbohydratesView.leadingAnchor),
            carbohydratesCountLabel.trailingAnchor.constraint(equalTo: carbohydratesView.trailingAnchor),
            carbohydratesCountLabel.bottomAnchor.constraint(equalTo: carbohydratesView.bottomAnchor),
        ])
    }

    private func setupFatsViewConstraint() {
        NSLayoutConstraint.activate([
            fatsView.leadingAnchor.constraint(equalTo: carbohydratesView.trailingAnchor, constant: 5),
            fatsView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            fatsView.heightAnchor.constraint(equalToConstant: 53),
            fatsView.widthAnchor.constraint(equalToConstant: 74)
        ])

        NSLayoutConstraint.activate([
            fatsLabel.topAnchor.constraint(equalTo: fatsView.topAnchor),
            fatsLabel.leadingAnchor.constraint(equalTo: fatsView.leadingAnchor),
            fatsLabel.trailingAnchor.constraint(equalTo: fatsView.trailingAnchor),
            fatsLabel.heightAnchor.constraint(equalToConstant: 31),
        ])

        NSLayoutConstraint.activate([
            fatsCountLabel.topAnchor.constraint(equalTo: fatsLabel.bottomAnchor),
            fatsCountLabel.leadingAnchor.constraint(equalTo: fatsView.leadingAnchor),
            fatsCountLabel.trailingAnchor.constraint(equalTo: fatsView.trailingAnchor),
            fatsCountLabel.bottomAnchor.constraint(equalTo: fatsView.bottomAnchor),
        ])
    }

    private func setupProteinsViewConstraint() {
        NSLayoutConstraint.activate([
            proteinsView.leadingAnchor.constraint(equalTo: fatsView.trailingAnchor, constant: 5),
            proteinsView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            proteinsView.heightAnchor.constraint(equalToConstant: 53),
            proteinsView.widthAnchor.constraint(equalToConstant: 74)
        ])

        NSLayoutConstraint.activate([
            proteinsLabel.topAnchor.constraint(equalTo: proteinsView.topAnchor),
            proteinsLabel.leadingAnchor.constraint(equalTo: proteinsView.leadingAnchor),
            proteinsLabel.trailingAnchor.constraint(equalTo: proteinsView.trailingAnchor),
            proteinsLabel.heightAnchor.constraint(equalToConstant: 31),
        ])

        NSLayoutConstraint.activate([
            proteinsCountLabel.topAnchor.constraint(equalTo: proteinsLabel.bottomAnchor),
            proteinsCountLabel.leadingAnchor.constraint(equalTo: proteinsView.leadingAnchor),
            proteinsCountLabel.trailingAnchor.constraint(equalTo: proteinsView.trailingAnchor),
            proteinsCountLabel.bottomAnchor.constraint(equalTo: proteinsView.bottomAnchor),
        ])
    }

    private func makeView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor().appMint
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor().appMint?.cgColor
        view.clipsToBounds = true
        return view
    }

    private func makeLabel(textColor: UIColor, text: String = "") -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 10)
        label.textColor = textColor
        label.textAlignment = .center
        label.text = text
        if textColor == UIColor.white {
            label.layer.borderColor = UIColor().appMint?.cgColor
            label.backgroundColor = UIColor().appMint
            label.layer.borderWidth = 1
        } else {
            label.backgroundColor = .white
            label.layer.borderWidth = 0
        }
        return label
    }
}
