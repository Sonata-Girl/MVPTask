// ImitatorScreenShimmerView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Класс для отображения Шиммера
final class ImitatorScreenShimmerView: UITableViewCell {
    // MARK: Private Property

    private let secondBigView = UIView() // большой квадрат
    private let longSmallView = UIView() // длинный вью прямоугольник
    private let stackView = UIStackView() // стеквью для отображения 4 одинаковых квадратов
    private let stackViewLongSecondView = UIStackView() // Стеквью для 5 прямоугольнико с низу
    private var greenView = UIView()
    private let gradientLayer = CAGradientLayer()
    private let gradientLayerFirst = CAGradientLayer()

    // MARK: Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        addConstarintStackView()
        addCostraint()
        setupView()
        setupStackView()
        startShimmer()
        setupGradient()
        // setupGradientFirst()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addView()
        addCostraint()
        addConstarintStackView()
        setupStackView()
        setupView()
        setupGradient()
//        setupGradientFirst()
    }

    // MARK: Private Method

    private func setupGradient() {
        gradientLayer.frame = greenView.bounds
        gradientLayer.colors = [
            UIColor(red: 222 / 255, green: 238 / 255, blue: 239 / 255, alpha: 1).cgColor,
            UIColor.white.cgColor
        ]
    }

//    private func setupGradientFirst() {
//        gradientLayerFirst.frame = bounds
//        gradientLayerFirst.colors = [
//            UIColor(red: 241 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1).cgColor,
//            UIColor.blue.cgColor
//        ]
//    }

    private func addView() {
        addSubview(secondBigView)
        addSubview(longSmallView)
        addSubview(stackView)
        addSubview(greenView)

        greenView.layer.addSublayer(gradientLayer)
        greenView.addSubview(stackViewLongSecondView)
    }

    private func startShimmer() {
        layoutIfNeeded()
        longSmallView.startShimmeringAnimation()
        stackView.startShimmeringAnimation()
        stackViewLongSecondView.startShimmeringAnimation()
        secondBigView.startShimmeringAnimation()
    }

    private func addConstarintStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 444).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        for _ in 1 ... 4 {
            let squareView = UIView()
            squareView.backgroundColor = .red
            squareView.translatesAutoresizingMaskIntoConstraints = false
            squareView.widthAnchor.constraint(equalToConstant: 74).isActive = true
            squareView.heightAnchor.constraint(equalToConstant: 53).isActive = true
            squareView.layer.cornerRadius = 16
            stackView.addArrangedSubview(squareView)
        }
        stackViewLongSecondView.translatesAutoresizingMaskIntoConstraints = false
        stackViewLongSecondView.topAnchor.constraint(equalTo: topAnchor, constant: 544).isActive = true
        stackViewLongSecondView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        for _ in 1 ... 5 {
            let lineView = UIView()
            lineView.backgroundColor = .red
            lineView.translatesAutoresizingMaskIntoConstraints = false
            lineView.widthAnchor.constraint(equalToConstant: 350).isActive = true
            lineView.heightAnchor.constraint(equalToConstant: 16).isActive = true
            stackViewLongSecondView.addArrangedSubview(lineView)
        }
    }

    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 5

        stackViewLongSecondView.axis = .vertical
        stackViewLongSecondView.alignment = .fill
        stackViewLongSecondView.distribution = .equalCentering
        stackViewLongSecondView.spacing = 5
    }

    private func addCostraint() {
        secondBigView.translatesAutoresizingMaskIntoConstraints = false
        secondBigView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        secondBigView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        secondBigView.topAnchor.constraint(equalTo: topAnchor, constant: 124).isActive = true
        secondBigView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45).isActive = true

        longSmallView.translatesAutoresizingMaskIntoConstraints = false
        longSmallView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        longSmallView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        longSmallView.topAnchor.constraint(equalTo: topAnchor, constant: 88).isActive = true
        longSmallView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true

        greenView.translatesAutoresizingMaskIntoConstraints = false
        greenView.widthAnchor.constraint(equalToConstant: 390).isActive = true
        greenView.heightAnchor.constraint(equalToConstant: 683).isActive = true
        greenView.topAnchor.constraint(equalTo: topAnchor, constant: 517).isActive = true
    }

    private func setupView() {
        longSmallView.backgroundColor = .red
        secondBigView.layer.cornerRadius = 24
        greenView.layer.cornerRadius = 24
        secondBigView.backgroundColor = .red
    }
}
