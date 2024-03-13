// PlaceholderFishView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Класс отвечающий за показ ошибки если данные не загрузились
final class PlaceholderFishView: UIView {
    // MARK: Constant

    enum Constant {
        static let firstLabel = "Failed to load data"
        static let secondLabel = "Reload"
        static let lightningImage = "lightning"
        static let rebootImage = "reboot"
        static let verdanaFont = "Verdana"
        static let reloadText = "Reload"
    }

    // MARK: Private Property

    private let firstView = UIView()
    private let secondView = UIView()
    private let lightningImageView = UIImageView()
    private let rebootImageView = UIImageView()
    private let firstTextLabel = UILabel()
    private let secondTextLabel = UILabel()

    // MARK: Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        addConstraintView()
        setupView()
        setupImageView()
        addConstraintImageView()
        setupLabel()
        addConstraintLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addView()
        addConstraintView()
        setupView()
        setupImageView()
        addConstraintImageView()
        setupLabel()
        addConstraintLabel()
    }

    // MARK: Private Method

    private func addView() {
        addSubview(firstTextLabel)
        addSubview(firstView)
        addSubview(secondView)
        firstView.addSubview(lightningImageView)
        secondView.addSubview(rebootImageView)
        secondView.addSubview(secondTextLabel)
    }

    private func addConstraintView() {
        firstView.translatesAutoresizingMaskIntoConstraints = false
        firstView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        firstView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        firstView.topAnchor.constraint(equalTo: topAnchor, constant: 368).isActive = true
        firstView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 167).isActive = true
        secondView.translatesAutoresizingMaskIntoConstraints = false
        secondView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        secondView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        secondView.topAnchor.constraint(equalTo: topAnchor, constant: 476).isActive = true
        secondView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 119).isActive = true
    }

    private func addConstraintImageView() {
        lightningImageView.translatesAutoresizingMaskIntoConstraints = false
        lightningImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        lightningImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        lightningImageView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 20).isActive = true
        lightningImageView.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 16).isActive = true
        rebootImageView.translatesAutoresizingMaskIntoConstraints = false
        rebootImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
        rebootImageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        rebootImageView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 41).isActive = true
        rebootImageView.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 9).isActive = true
    }

    private func addConstraintLabel() {
        firstTextLabel.translatesAutoresizingMaskIntoConstraints = false
        firstTextLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        firstTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        firstTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21).isActive = true
        firstTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 435).isActive = true
        secondTextLabel.translatesAutoresizingMaskIntoConstraints = false
        secondTextLabel.widthAnchor.constraint(equalToConstant: 46).isActive = true
        secondTextLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        secondTextLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 64).isActive = true
        secondTextLabel.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 4).isActive = true
    }

    private func setupView() {
        firstView.backgroundColor = #colorLiteral(red: 0.9483424833, green: 0.9605068627, blue: 0.980357763, alpha: 1)
        firstView.layer.cornerRadius = 12
        secondView.backgroundColor = #colorLiteral(red: 0.9483424833, green: 0.9605068627, blue: 0.980357763, alpha: 1)
        secondView.layer.cornerRadius = 12
    }

    private func setupImageView() {
        lightningImageView.image = UIImage(named: Constant.lightningImage)
        rebootImageView.image = UIImage(named: Constant.rebootImage)
    }

    private func setupLabel() {
        firstTextLabel.text = Constant.firstLabel
        firstTextLabel.font = .addFont(Constant.verdanaFont, 14)
        firstTextLabel.textAlignment = .center
        firstTextLabel.textColor = .rgba(151, 162, 176, 1)

        secondTextLabel.text = Constant.secondLabel
        secondTextLabel.font = .addFont(Constant.verdanaFont, 14)
        secondTextLabel.textAlignment = .center
        secondTextLabel.textColor = .rgba(151, 162, 176, 1)
    }
}
