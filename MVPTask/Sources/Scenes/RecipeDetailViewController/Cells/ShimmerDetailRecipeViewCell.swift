// ShimmerDetailRecipeViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Класс для отображения Шиммера
final class ShimmerDetailRecipeViewCell: UITableViewCell {
    // MARK: Constants

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Private Property

    private let secondBigView = UIView() // большой квадрат
    private let longSmallView = UIView() // длинный вью прямоугольник
    private let blocksStackView = UIStackView() // стеквью для отображения 4 одинаковых квадратов
    private let linesStackView = UIStackView() // Стеквью для 5 прямоугольнико с низу
    private var greenView = UIView()
    private let gradientLayer = CAGradientLayer()

    // MARK: Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setupConstraints()
        setupStackView()
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addView()
        setupConstraints()
        setupView()
    }

    // MARK: Public Method

    func startShimmer() {
        layoutIfNeeded()
        longSmallView.startShimmeringAnimation(animationSpeed: 2.0)
        blocksStackView.startShimmeringAnimation(animationSpeed: 2.0)
        linesStackView.startShimmeringAnimation(animationSpeed: 2.0)
        secondBigView.startShimmeringAnimation(animationSpeed: 2.0)
    }

    // MARK: Private Method

    private func addView() {
        contentView.addSubview(secondBigView)
        contentView.addSubview(longSmallView)
        contentView.addSubview(blocksStackView)
        contentView.addSubview(greenView)
        greenView.addSubview(linesStackView)
    }

    private func setupStackView() {
        blocksStackView.axis = .horizontal
        blocksStackView.alignment = .fill
        blocksStackView.distribution = .equalSpacing
        blocksStackView.spacing = 5

        linesStackView.axis = .vertical
        linesStackView.alignment = .fill
        linesStackView.distribution = .equalCentering
        linesStackView.spacing = 5
    }

    private func setupConstraints() {
        heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 120).isActive = true

        setupLongSmallViewConstraints()
        setupSecondBigViewConstraints()
        setupBlocksStackViewConstraints()
        setupGreenViewConstraints()
        setupLinesStackViewConstraints()
    }

    private func setupLongSmallViewConstraints() {
        longSmallView.translatesAutoresizingMaskIntoConstraints = false
        longSmallView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        longSmallView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        longSmallView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -20
        ).isActive = true
        longSmallView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func setupSecondBigViewConstraints() {
        secondBigView.translatesAutoresizingMaskIntoConstraints = false
        secondBigView.topAnchor.constraint(equalTo: longSmallView.bottomAnchor, constant: 20).isActive = true
        secondBigView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45).isActive = true
        secondBigView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45).isActive = true
        secondBigView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    private func setupBlocksStackViewConstraints() {
        blocksStackView.translatesAutoresizingMaskIntoConstraints = false
        blocksStackView.topAnchor.constraint(equalTo: secondBigView.bottomAnchor, constant: 10).isActive = true
        blocksStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        blocksStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        for _ in 1 ... 4 {
            let squareView = UIView()
            squareView.backgroundColor = UIColor().appLightMint
            squareView.translatesAutoresizingMaskIntoConstraints = false
            squareView.widthAnchor.constraint(equalToConstant: 74).isActive = true
            squareView.heightAnchor.constraint(equalToConstant: 53).isActive = true
            squareView.layer.cornerRadius = 16
            blocksStackView.addArrangedSubview(squareView)
        }
    }

    private func setupGreenViewConstraints() {
        greenView.translatesAutoresizingMaskIntoConstraints = false
        greenView.topAnchor.constraint(equalTo: blocksStackView.bottomAnchor, constant: 15).isActive = true
        greenView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        greenView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        greenView.heightAnchor.constraint(equalToConstant: 683).isActive = true
    }

    private func setupLinesStackViewConstraints() {
        linesStackView.translatesAutoresizingMaskIntoConstraints = false
        linesStackView.topAnchor.constraint(
            equalTo: greenView.topAnchor, constant: 10
        ).isActive = true
        linesStackView.leadingAnchor.constraint(
            equalTo: greenView.leadingAnchor, constant: 30
        ).isActive = true
        linesStackView.trailingAnchor.constraint(
            equalTo: greenView.trailingAnchor,
            constant: -30
        ).isActive = true

        for _ in 1 ... 5 {
            let lineView = UIView()
            lineView.backgroundColor = .white
            lineView.translatesAutoresizingMaskIntoConstraints = false
            lineView.widthAnchor.constraint(equalToConstant: 350).isActive = true
            lineView.heightAnchor.constraint(equalToConstant: 16).isActive = true
            linesStackView.addArrangedSubview(lineView)
        }
    }

    private func setupView() {
        longSmallView.backgroundColor = UIColor().appLightMint
        secondBigView.layer.cornerRadius = 24
        greenView.layer.cornerRadius = 25
        secondBigView.backgroundColor = UIColor().appLightMint
        backgroundColor = .white
        greenView.backgroundColor = UIColor().appLightMint
    }
}
