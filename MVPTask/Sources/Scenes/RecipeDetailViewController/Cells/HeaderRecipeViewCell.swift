// HeaderRecipeViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения главной информации о рецепте ( заголовок детального экрана рецептов)
final class HeaderRecipeViewCell: UITableViewCell {
    // MARK: Constants

    private enum Constants {
        static let gramText = "g"
        static let timeText = "min"
        static let weightImageName = "weightRecipeIcon"
        static let shareButtonImage = "paperplane"
        static let bookMarkImage = "bookmark"
        static let timeImageName = "timer"
        static let timeTitle = "Cooking time"
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private let recipeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdanaBold(withSize: 25)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24
        return imageView
    }()

    private let weightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.backgroundColor = UIColor().appMint
        return view
    }()

    private let weightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: Constants.weightImageName)
        return imageView
    }()

    private lazy var weightCountLabel = makeLabel(color: .white)

    private let timeRecipeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        view.backgroundColor = UIColor().appMint
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return view
    }()

    private let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: Constants.timeImageName)
        return imageView
    }()

    private lazy var timeRecipeTitleLabel = makeLabel(color: .white)

    private lazy var timeRecipeCountLabel = makeLabel(color: .white)

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
        mainImageView.image = nil
        weightCountLabel.text = nil
        timeRecipeCountLabel.text = nil
    }

    // MARK: Public methods

    func configureCell(recipe: Recipe) {
        recipeLabel.text = recipe.name
        mainImageView.image = UIImage(named: recipe.imageName)
        weightCountLabel.text = "\(recipe.weightGram) \(Constants.gramText)"
        timeRecipeCountLabel.text = "\(recipe.cookingTimeInMinutes) \(Constants.timeText)"
        timeRecipeTitleLabel.text = Constants.timeTitle
    }

    // MARK: Private Methods

    private func setupView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        selectedBackgroundView = backgroundView
    }

    private func setupHierarchy() {
        [
            recipeLabel,
            mainImageView,
        ].forEach { contentView.addSubview($0) }

        [
            weightView,
            timeRecipeView
        ].forEach { mainImageView.addSubview($0) }

        [
            weightImageView,
            weightCountLabel,
        ].forEach { weightView.addSubview($0) }

        [
            timeImageView,
            timeRecipeTitleLabel,
            timeRecipeCountLabel
        ].forEach { timeRecipeView.addSubview($0) }
    }

    private func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 380).isActive = true

        setupRecipeLabelConstraint()
        setupMainImageViewConstraint()
        setupWeightViewConstraint()
        setupWeightImageViewConstraint()
        setupWeightCountLabelConstraint()
        setupTimeRecipeViewConstraint()
        setupTimeImageViewConstraint()
        setupTimeRecipeTitleLabelConstraint()
        setupTimeRecipeCountLabelConstraint()
    }

    private func setupRecipeLabelConstraint() {
        NSLayoutConstraint.activate([
            recipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }

    private func setupMainImageViewConstraint() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor, constant: 5),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            mainImageView.heightAnchor.constraint(equalToConstant: 300),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setupWeightViewConstraint() {
        NSLayoutConstraint.activate([
            weightView.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 6),
            weightView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -6),
            weightView.heightAnchor.constraint(equalToConstant: 50),
            weightView.widthAnchor.constraint(equalToConstant: 50),
        ])
    }

    private func setupWeightImageViewConstraint() {
        NSLayoutConstraint.activate([
            weightImageView.topAnchor.constraint(equalTo: weightView.topAnchor, constant: 7),
            weightImageView.leadingAnchor.constraint(equalTo: weightView.leadingAnchor, constant: 15),
            weightImageView.trailingAnchor.constraint(equalTo: weightView.trailingAnchor, constant: -15),
            weightImageView.heightAnchor.constraint(equalToConstant: 17),
        ])
    }

    private func setupWeightCountLabelConstraint() {
        NSLayoutConstraint.activate([
            weightCountLabel.topAnchor.constraint(equalTo: weightImageView.bottomAnchor, constant: 7),
            weightCountLabel.leadingAnchor.constraint(equalTo: weightView.leadingAnchor, constant: 4),
            weightCountLabel.trailingAnchor.constraint(equalTo: weightView.trailingAnchor, constant: -6),
            weightCountLabel.bottomAnchor.constraint(equalTo: weightView.bottomAnchor, constant: -7),
        ])
    }

    private func setupTimeRecipeViewConstraint() {
        NSLayoutConstraint.activate([
            timeRecipeView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor),
            timeRecipeView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            timeRecipeView.heightAnchor.constraint(equalToConstant: 48),
            timeRecipeView.widthAnchor.constraint(equalToConstant: 124),
        ])
    }

    private func setupTimeImageViewConstraint() {
        NSLayoutConstraint.activate([
            timeImageView.topAnchor.constraint(equalTo: timeRecipeView.topAnchor, constant: 12),
            timeImageView.leadingAnchor.constraint(equalTo: timeRecipeView.leadingAnchor, constant: 8),
            timeImageView.bottomAnchor.constraint(equalTo: timeRecipeView.bottomAnchor, constant: -12),
            timeImageView.widthAnchor.constraint(equalToConstant: 25),
        ])
    }

    private func setupTimeRecipeTitleLabelConstraint() {
        NSLayoutConstraint.activate([
            timeRecipeTitleLabel.topAnchor.constraint(equalTo: timeRecipeView.topAnchor, constant: 10),
            timeRecipeTitleLabel.leadingAnchor.constraint(equalTo: timeImageView.trailingAnchor, constant: 5),
            timeRecipeTitleLabel.trailingAnchor.constraint(equalTo: timeRecipeView.trailingAnchor, constant: -8),
            timeRecipeTitleLabel.heightAnchor.constraint(equalToConstant: 15),
        ])
    }

    private func setupTimeRecipeCountLabelConstraint() {
        NSLayoutConstraint.activate([
            timeRecipeCountLabel.topAnchor.constraint(equalTo: timeRecipeTitleLabel.bottomAnchor),
            timeRecipeCountLabel.leadingAnchor.constraint(equalTo: timeRecipeTitleLabel.leadingAnchor),
            timeRecipeCountLabel.trailingAnchor.constraint(equalTo: timeRecipeView.trailingAnchor, constant: -8),
            timeRecipeCountLabel.bottomAnchor.constraint(equalTo: timeRecipeView.bottomAnchor)
        ])
    }

    private func makeLabel(color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 10)
        label.textColor = color
        label.textAlignment = .center
        return label
    }
}
