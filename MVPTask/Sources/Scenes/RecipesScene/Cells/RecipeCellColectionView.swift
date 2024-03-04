// RecipeCellColectionView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Класс для регистрации ячейки для коллекции
class RecipeCellColectionView: UICollectionViewCell {
    // MARK: Publick Property

    // MARK: Constant

    enum Constant {
        static let nameImageView = "soup"
    }

    let recipeCellColectionView = "RecipeCellColectionView"

    // MARK: Private Property

    private let nameImageView = UIImageView()
    private let nameLabel = UILabel()
    private let screenView = UIView()
    private let translitionButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupView()
        setupLabel()
        setupContentView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setupImageView()
        setupView()
        setupLabel()
        setupContentView()
    }

    private func setupContentView() {
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
    }

    private func setupImageView() {
        contentView.addSubview(nameImageView)

        nameImageView.contentMode = .scaleAspectFill
        nameImageView.clipsToBounds = true
        nameImageView.translatesAutoresizingMaskIntoConstraints = false
        nameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        nameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        nameImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func setupView() {
        contentView.addSubview(screenView)
        screenView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        screenView.alpha = 0.82
        screenView.translatesAutoresizingMaskIntoConstraints = false
        screenView.leadingAnchor.constraint(equalTo: nameImageView.leadingAnchor).isActive = true
        screenView.trailingAnchor.constraint(equalTo: nameImageView.trailingAnchor).isActive = true
        screenView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        screenView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func setupLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: screenView.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: screenView.centerYAnchor).isActive = true
        nameLabel.textColor = #colorLiteral(red: 0.9567841887, green: 0.9992051721, blue: 1, alpha: 1)
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "Verdana", size: 20)
    }

    func configureCell(param: Category) {
        nameImageView.image = UIImage(named: param.imageName)
        nameLabel.text = param.name
    }
}
