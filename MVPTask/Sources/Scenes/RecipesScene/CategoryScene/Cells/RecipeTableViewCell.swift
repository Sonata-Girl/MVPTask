// RecipeTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения рецетов
class RecipeTableViewCell: UITableViewCell {
    // MARK: Constants

    private enum Constants {
        static let arrowImageName = "rightChevron"
        static let pizzaImageName = "pizzaIcon"
        static let timerImageName = "timerIcon"
        static let minutesTitle = "min"
        static let caloriesTitle = "kkal"
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    lazy var arrowButton: UIImageView = {
        let imageView = makeImageView()
        imageView.image = UIImage(named: Constants.arrowImageName)
        return imageView
    }()

    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor().appLightMint
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor().appMint?.cgColor
        return view
    }()

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
        label.numberOfLines = 2
        return label
    }()

    private lazy var timerImageView: UIImageView = {
        let imageView = makeImageView()
        imageView.image = UIImage(named: Constants.timerImageName)
        return imageView
    }()

    private lazy var timerLabel: UILabel = makeLabel()

    private lazy var caloriesImageView: UIImageView = {
        let imageView = makeImageView()
        imageView.image = UIImage(named: Constants.pizzaImageName)
        return imageView
    }()

    private lazy var caloriesLabel: UILabel = makeLabel()

    // MARK: Private Properties

    override var isSelected: Bool {
        didSet {
            mainView.layer.borderWidth = isSelected ? 2 : 0
        }
    }

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
        recipeImageView.image = nil
        recipeNameLabel.text = nil
        timerLabel.text = nil
        caloriesLabel.text = nil
    }

    // MARK: Public methods

    func selectCell() {
        setupStateCell()
    }

    func configureCell(recipe: Recipe) {
        recipeImageView.image = UIImage(named: recipe.imageName)
        recipeNameLabel.text = recipe.name
        timerLabel.text = "\(recipe.cookingTimeInMinutes) \(Constants.minutesTitle)"
        caloriesLabel.text = "\(recipe.caloriesCount) \(Constants.caloriesTitle)"
    }

    // MARK: Private Methods

    private func setupView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        selectedBackgroundView = backgroundView
    }

    private func setupStateCell() {
        mainView.layer.borderWidth = isSelected ? 2 : 0
    }

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

    private func setupHierarchy() {
        contentView.addSubview(mainView)
        [
            recipeImageView,
            recipeNameLabel,
            timerImageView,
            timerLabel,
            caloriesImageView,
            caloriesLabel,
            arrowButton
        ].forEach { mainView.addSubview($0) }
    }

    private func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 114).isActive = true

        setupMainViewConstraint()
        setupRecipeImageViewConstraint()
        setupRecipeNameLabelConstraint()
        setupTimerImageViewConstraint()
        setupTimerLabelConstraint()
        setupCaloriesImageViewConstraint()
        setupCaloriesLabelConstraint()
        setupArrowButtonConstraint()
    }

    private func setupMainViewConstraint() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
        ])
    }

    private func setupRecipeImageViewConstraint() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            recipeImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            recipeImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            recipeImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setupRecipeNameLabelConstraint() {
        NSLayoutConstraint.activate([
            recipeNameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            recipeNameLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20),
            recipeNameLabel.heightAnchor.constraint(equalToConstant: 35)
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
            caloriesImageView.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 8),
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
            arrowButton.leadingAnchor.constraint(equalTo: recipeNameLabel.trailingAnchor),
            arrowButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            arrowButton.widthAnchor.constraint(equalToConstant: 40),
            arrowButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
