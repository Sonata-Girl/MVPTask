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
        static let placeholderEmailAdress = "Enter Email Address"
        static let placeholderPassword = "Enter Password"
        static let envelopeButton = "envelope"
        static let textLoginButton = "Login"
        static let fontVerdana = "Verdana"
        static let lockButton = "lock"
        static let eyeButton = "eye"
        static let crossButton = "cross"
    }

    var presenter: LoginViewPresenterProtocol?

    // MARK: Private Property

    private let loginLabel = UILabel()
    private let emailAddressLabel = UILabel()
    private let passwordLabel = UILabel()
    private let emailAddressTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let lockButton = UIButton()
    private let textFildLoginView = UIView()
    private let envelopeButton = UIButton()
    private let textFildLoginViewTwo = UIView()
    private let eyeButton = UIButton()
    private let gradientView = UIView()
    private let gredient = CAGradientLayer()
    private let crossButton = UIButton()

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addView()
        addConstrainsLabel()
        addConstrainsTextField()
        addConstrainsButton()
        setupAddConstrainsView()
        setupLabel()
        setupTextField()
        setupButton()
        setupView()
        setupGradient()
    }

    // MARK: Private Method

    private func addView() {
        gradientView.layer.addSublayer(gredient)
        gradientView.addSubview(loginLabel)
        gradientView.addSubview(emailAddressLabel)
        gradientView.addSubview(passwordLabel)
        textFildLoginView.addSubview(emailAddressTextField)
        gradientView.addSubview(loginButton)
        gradientView.addSubview(textFildLoginView)
        textFildLoginView.addSubview(envelopeButton)
        gradientView.addSubview(textFildLoginViewTwo)
        textFildLoginViewTwo.addSubview(passwordTextField)
        textFildLoginViewTwo.addSubview(lockButton)
        textFildLoginViewTwo.addSubview(eyeButton)
        view.addSubview(gradientView)
        view.addSubview(crossButton)
    }

    private func setupGradient() {
        let colorOneGradient = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        let colorTwoGradient = #colorLiteral(red: 0.8705882353, green: 0.9333333333, blue: 0.937254902, alpha: 1).cgColor
        gredient.colors = [colorOneGradient, colorTwoGradient]
        gredient.locations = [0, 1]
        gredient.frame = view.bounds
    }

    private func setupView() {
        textFildLoginView.backgroundColor = .white
        textFildLoginView.layer.cornerRadius = 12
        textFildLoginView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textFildLoginView.layer.borderWidth = 1

        textFildLoginViewTwo.backgroundColor = .white
        textFildLoginViewTwo.layer.cornerRadius = 12
        textFildLoginViewTwo.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textFildLoginViewTwo.layer.borderWidth = 1

        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func setupAddConstrainsView() {
        textFildLoginView.translatesAutoresizingMaskIntoConstraints = false
        textFildLoginView.translatesAutoresizingMaskIntoConstraints = false
        textFildLoginView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        textFildLoginView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textFildLoginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textFildLoginView.topAnchor.constraint(equalTo: view.topAnchor, constant: 175).isActive = true

        textFildLoginViewTwo.translatesAutoresizingMaskIntoConstraints = false
        textFildLoginViewTwo.translatesAutoresizingMaskIntoConstraints = false
        textFildLoginViewTwo.widthAnchor.constraint(equalToConstant: 350).isActive = true
        textFildLoginViewTwo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textFildLoginViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textFildLoginViewTwo.topAnchor.constraint(equalTo: view.topAnchor, constant: 287).isActive = true
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
        loginLabel.font = .setVerdanaBold(withSize: 28)
        loginLabel.textAlignment = .left
        loginLabel.textColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1)

        emailAddressLabel.text = Constanta.emailAdressText
        emailAddressLabel.font = .setVerdanaBold(withSize: 18)
        emailAddressLabel.textAlignment = .left
        emailAddressLabel.textColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1)

        passwordLabel.text = Constanta.passwordText
        passwordLabel.font = .setVerdanaBold(withSize: 18)
        passwordLabel.textAlignment = .left
        passwordLabel.textColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1)
    }

    private func addConstrainsTextField() {
        emailAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        emailAddressTextField.widthAnchor.constraint(equalToConstant: 255).isActive = true
        emailAddressTextField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        emailAddressTextField.leadingAnchor.constraint(
            equalTo: textFildLoginView.leadingAnchor,
            constant: 50
        ).isActive = true
        emailAddressTextField.topAnchor.constraint(
            equalTo: textFildLoginView.topAnchor,
            constant: 14
        ).isActive = true

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.widthAnchor.constraint(equalToConstant: 255).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        passwordTextField.leadingAnchor.constraint(
            equalTo: textFildLoginViewTwo.leadingAnchor,
            constant: 50
        ).isActive = true
        passwordTextField.topAnchor.constraint(
            equalTo: textFildLoginViewTwo.topAnchor,
            constant: 14
        ).isActive = true
    }

    private func setupTextField() {
        let placeholderTwo = Constanta.placeholderEmailAdress
        emailAddressTextField.attributedPlaceholder = NSAttributedString(
            string: placeholderTwo,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(
                red: 151 / 255, green: 162 / 255, blue: 176 / 255, alpha: 1
            )]
        )

        let placeholderText = Constanta.placeholderPassword
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(
                red: 151 / 255, green: 162 / 255, blue: 176 / 255, alpha: 1
            )]
        )
    }

    private func addConstrainsButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 725).isActive = true

        envelopeButton.translatesAutoresizingMaskIntoConstraints = false
        envelopeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        envelopeButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        envelopeButton.leadingAnchor.constraint(
            equalTo: textFildLoginView.leadingAnchor,
            constant: 17
        ).isActive = true
        envelopeButton.topAnchor.constraint(
            equalTo: textFildLoginView.topAnchor,
            constant: 18
        ).isActive = true

        lockButton.translatesAutoresizingMaskIntoConstraints = false
        lockButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        lockButton.heightAnchor.constraint(equalToConstant: 21).isActive = true
        lockButton.leadingAnchor.constraint(
            equalTo: textFildLoginViewTwo.leadingAnchor,
            constant: 19
        ).isActive = true
        lockButton.topAnchor.constraint(
            equalTo: textFildLoginViewTwo.topAnchor,
            constant: 14
        ).isActive = true

        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        eyeButton.heightAnchor.constraint(equalToConstant: 19).isActive = true
        eyeButton.leadingAnchor.constraint(
            equalTo: textFildLoginViewTwo.leadingAnchor,
            constant: 314
        ).isActive = true
        eyeButton.topAnchor.constraint(
            equalTo: textFildLoginViewTwo.topAnchor,
            constant: 17
        ).isActive = true

        crossButton.translatesAutoresizingMaskIntoConstraints = false
        crossButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        crossButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        crossButton.leadingAnchor.constraint(
            equalTo: textFildLoginView.leadingAnchor,
            constant: 315
        ).isActive = true
        crossButton.topAnchor.constraint(
            equalTo: textFildLoginView.topAnchor,
            constant: 15
        ).isActive = true
    }

    private func setupButton() {
        envelopeButton.setImage(UIImage(named: Constanta.envelopeButton), for: .normal)
        lockButton.setImage(UIImage(named: Constanta.lockButton), for: .normal)
        eyeButton.setImage(UIImage(named: Constanta.eyeButton), for: .normal)
        crossButton.setImage(UIImage(named: Constanta.crossButton), for: .normal)
        loginButton.setTitle(Constanta.textLogin, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: Constanta.textLogin, size: 16)
        loginButton.tintColor = UIColor.white
        loginButton.backgroundColor = UIColor(red: 4 / 255, green: 38 / 255, blue: 40 / 255, alpha: 1)
        loginButton.layer.cornerRadius = 12
    }
}
