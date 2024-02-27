// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый экран авторизации пользователя
final class LoginViewController: UIViewController {
    // MARK: Constant

    enum Constanta {
        static let textLogin = "Login"
        static let emailAdressText = "Email Address"
        static let passwordText = "Password"
        static let verdanaBoldFont = "Verdana-Bold"
        static let placeholderEmailAdress = "Enter Email Address"
        static let placeholderPassword = "Enter Password"
        static let envelopeButton = "envelope"
        static let textLoginButton = "Login"
        static let fontVerdana = "Verdana"
    }

    // MARK: Private Property

    private let loginLabel = UILabel()
    private let emailAddressLabel = UILabel()
    private let passwordLabel = UILabel()
    private let emailAddressTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
//    private one

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        addConstrainsLabel()
        addConstrainsTextField()
        addConstrainsButton()
        setupLabel()
        setupTextField()
        setupButton()
    }

    // MARK: Private Method

    private func addView() {
        view.addSubview(loginLabel)
        view.addSubview(emailAddressLabel)
        view.addSubview(emailAddressTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }

    private func addConstrainsLabel() {
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        loginLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 82).isActive = true

        emailAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        emailAddressLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        emailAddressLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        emailAddressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailAddressLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 137).isActive = true

        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 248).isActive = true
    }

    private func setupLabel() {
        loginLabel.text = Constanta.textLogin
        loginLabel.font = UIFont(name: Constanta.verdanaBoldFont, size: 28)
        loginLabel.textAlignment = .left
        loginLabel.textColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1)

        emailAddressLabel.text = Constanta.emailAdressText
        emailAddressLabel.font = UIFont(name: Constanta.verdanaBoldFont, size: 18)
        emailAddressLabel.textAlignment = .left
        emailAddressLabel.textColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1)

        passwordLabel.text = Constanta.passwordText
        passwordLabel.font = UIFont(name: Constanta.verdanaBoldFont, size: 18)
        passwordLabel.textAlignment = .left
        passwordLabel.textColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1)
    }

    private func addConstrainsTextField() {
        emailAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        emailAddressTextField.widthAnchor.constraint(equalToConstant: 255).isActive = true
        emailAddressTextField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        emailAddressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailAddressTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 175).isActive = true

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.widthAnchor.constraint(equalToConstant: 255).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 287).isActive = true
    }

    private func setupTextField() {
        emailAddressTextField.placeholder = Constanta.placeholderEmailAdress
        passwordTextField.placeholder = Constanta.placeholderPassword
    }

    private func addConstrainsButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 725).isActive = true
    }

    private func setupButton() {
        loginButton.setTitle(Constanta.textLogin, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: Constanta.textLogin, size: 16)
        loginButton.tintColor = .white
        loginButton.backgroundColor = UIColor(red: 4 / 255, green: 38 / 255, blue: 40 / 255, alpha: 1)
        loginButton.layer.cornerRadius = 12
    }
}
