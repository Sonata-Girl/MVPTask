// FavoritesPlaceholderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Класс отвечающий за отображение главного экрана
final class FavoritesPlaceholderView: UIView {
    // MARK: Constant

    enum Constant {
        static let offTextLabel = "Add interesting recipes to make ordering products \n convenient"
        static let addRecipteLabel = "There's nothing here yet"
        static let image = "coco"
    }

    // MARK: Private Property

    private var imageView = UIImageView()
    private let addTextLabel = UILabel()
    private let offTextLabel = UILabel()
    private let frameUnderView = UIView()

    // MARK: Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        addConstraint()
        setupElementMainScreen()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addView()
        addConstraint()
        setupElementMainScreen()
    }

    // MARK: Private Methods

    private func addView() {
        frameUnderView.addSubview(imageView)
        addSubview(offTextLabel)
        addSubview(frameUnderView)
        addSubview(addTextLabel)
    }

    private func addConstraint() {
        frameUnderView.translatesAutoresizingMaskIntoConstraints = false
        frameUnderView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        frameUnderView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        frameUnderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 156).isActive = true
        frameUnderView.topAnchor.constraint(equalTo: topAnchor, constant: 356).isActive = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.leadingAnchor.constraint(equalTo: frameUnderView.leadingAnchor, constant: 13).isActive = true
        imageView.topAnchor.constraint(equalTo: frameUnderView.topAnchor, constant: 13).isActive = true

        offTextLabel.translatesAutoresizingMaskIntoConstraints = false
        offTextLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        offTextLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        offTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        offTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 456).isActive = true

        addTextLabel.translatesAutoresizingMaskIntoConstraints = false
        addTextLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        addTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        addTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        addTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 423).isActive = true
    }

    private func setupElementMainScreen() {
        frameUnderView.backgroundColor = #colorLiteral(red: 0.9483424833, green: 0.9605068627, blue: 0.980357763, alpha: 1)
        frameUnderView.layer.cornerRadius = 12
        imageView.image = UIImage(named: Constant.image)

        offTextLabel.numberOfLines = 0
        offTextLabel.clipsToBounds = true
        offTextLabel.text = Constant.offTextLabel
        offTextLabel.font = .addVerdana(withSize: 12.5)
        offTextLabel.textAlignment = .center
        offTextLabel.textColor = #colorLiteral(red: 0.5914113898, green: 0.633750514, blue: 0.6919073808, alpha: 1)

        addTextLabel.text = Constant.addRecipteLabel
        addTextLabel.font = .addVerdanaBold(withSize: 18)
        addTextLabel.textAlignment = .center
        addTextLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
