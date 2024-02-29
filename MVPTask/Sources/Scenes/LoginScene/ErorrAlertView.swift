// ErorrAlertView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Класс для отображения ошибки
final class ErorrAlertView: UIView {
    // MARK: Private Property

    private let errorLabel = UILabel()

    // MARK: Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupErrorView()
        setupLavelError()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupErrorView() {
        backgroundColor = UIColor(red: 240 / 255, green: 97 / 255, blue: 85 / 255, alpha: 1)
        layer.cornerRadius = 12
    }

    // MARK: Private Method

    private func setupLavelError() {
        errorLabel.text = "Please check the accuracy of the entered credentials."
        errorLabel.textColor = .white
        errorLabel.textAlignment = .left
        errorLabel.font = UIFont(name: "Verdana", size: 18)
        errorLabel.numberOfLines = 2
        addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        errorLabel.widthAnchor.constraint(equalToConstant: 301).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 54).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        errorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    }
}
