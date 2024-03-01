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
    private var activityIndicator = UIActivityIndicatorView()
    private let icncorenFormatLabel = UILabel()
    private let icncorenPasswordLabel = UILabel()
    private let errorView = ErorrAlertView()
    private var bottomConstraint: NSLayoutConstraint?
    private var errorAlertBottomConstraint: NSLayoutConstraint?

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
        registerForKeyboardNotifications()
        setupActivityIndicator()
        setupKeyboardToolBar()
    }

    override func touchesBegan(_ touchesSet: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: Private Method

    private func addView() {
        gradientView.layer.addSublayer(gredient)
        gradientView.addSubview(loginLabel)
        gradientView.addSubview(emailAddressLabel)
        gradientView.addSubview(passwordLabel)
        textFildLoginView.addSubview(emailAddressTextField)
        gradientView.addSubview(errorView)
        gradientView.addSubview(loginButton)
        gradientView.addSubview(textFildLoginView)
        textFildLoginView.addSubview(envelopeButton)
        gradientView.addSubview(textFildLoginViewTwo)
        textFildLoginViewTwo.addSubview(passwordTextField)
        textFildLoginViewTwo.addSubview(lockButton)
        textFildLoginViewTwo.addSubview(eyeButton)
        view.addSubview(gradientView)
        view.addSubview(crossButton)
        view.addSubview(icncorenFormatLabel)
        view.addSubview(icncorenPasswordLabel)
    }

    private func setupKeyboardToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(hideKeyboard))
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        passwordTextField.inputAccessoryView = toolBar
        emailAddressTextField.inputAccessoryView = toolBar
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

        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.heightAnchor.constraint(equalToConstant: 87).isActive = true
        errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorAlertBottomConstraint = errorView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: 115
        )
        errorAlertBottomConstraint?.isActive = true
        errorView.widthAnchor.constraint(equalToConstant: 320).isActive = true
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

        icncorenFormatLabel.text = "Incorrect format"
        icncorenFormatLabel.font = UIFont(name: Constanta.fontVerdana, size: 12)
        icncorenFormatLabel.textAlignment = .left
        icncorenFormatLabel.textColor = .red
        icncorenFormatLabel.isHidden = true
        icncorenFormatLabel.translatesAutoresizingMaskIntoConstraints = false
        icncorenFormatLabel.widthAnchor.constraint(equalToConstant: 230).isActive = true
        icncorenFormatLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        icncorenFormatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        icncorenFormatLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 225).isActive = true

        icncorenPasswordLabel.text = "You entered the wrong password"
        icncorenPasswordLabel.isHidden = true
        icncorenPasswordLabel.font = UIFont(name: Constanta.fontVerdana, size: 12)
        icncorenPasswordLabel.textAlignment = .left
        icncorenPasswordLabel.textColor = .red
        icncorenPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        icncorenPasswordLabel.widthAnchor.constraint(equalToConstant: 230).isActive = true
        icncorenPasswordLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        icncorenPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        icncorenPasswordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 338).isActive = true
    }

    private func addConstrainsTextField() {
        emailAddressTextField.delegate = self
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

        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
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
        bottomConstraint = loginButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -75
        )
        bottomConstraint?.isActive = true
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

        eyeButton.addTarget(self, action: #selector(hiddenTextTapped), for: .touchUpInside)
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
        crossButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
    }

    private func setupButton() {
        envelopeButton.setImage(UIImage(named: Constanta.envelopeButton), for: .normal)
        lockButton.setImage(UIImage(named: Constanta.lockButton), for: .normal)
        eyeButton.setImage(UIImage(named: Constanta.eyeButton), for: .normal)
        crossButton.setImage(UIImage(named: Constanta.crossButton), for: .normal)
        loginButton.setTitle(Constanta.textLogin, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.titleLabel?.font = UIFont(name: Constanta.textLogin, size: 16)
        loginButton.tintColor = UIColor.white
        loginButton.backgroundColor = UIColor(red: 4 / 255, green: 38 / 255, blue: 40 / 255, alpha: 1)
        loginButton.layer.cornerRadius = 12
    }

    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = UIColor.red
        loginButton.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor).isActive = true
    }

    private func lockLoginButton() {
        loginButton.setTitle("", for: .normal)
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.loginButton.setTitle("Login", for: .normal)
            self.activityIndicator.stopAnimating()
        }
    }

    @objc private func loginButtonTapped() {
        lockLoginButton()
        presenter?.validatePassword(password: passwordTextField.text ?? "")
        UIView.animate(withDuration: 1.5) {
            self.errorAlertBottomConstraint?.constant = -110
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 1.5) {
                self.errorAlertBottomConstraint?.constant = 250
            }
        }
    }

    @objc private func hiddenTextTapped() {
        passwordTextField.isSecureTextEntry.toggle()
    }

    @objc private func clearText() {
        emailAddressTextField.text = ""
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - LoginViewProtocol

/// LoginViewController + LoginViewProtocol
extension LoginViewController: LoginViewProtocol {
    func changeEmailColor(valideStyle: ValideStyle) {
        switch valideStyle {
        case .valid:
            icncorenFormatLabel.isHidden = true
            emailAddressLabel.textColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1)
        case .notValide:
            icncorenFormatLabel.isHidden = false
            emailAddressLabel.textColor = .red
        }
    }

    func changePasswordColor(valideStyle: ValideStyle) {
        switch valideStyle {
        case .valid:
            icncorenPasswordLabel.isHidden = true
            icncorenPasswordLabel.textColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1)
        case .notValide:
            icncorenPasswordLabel.isHidden = false
            icncorenPasswordLabel.textColor = .red
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter?.validateEmail(email: emailAddressTextField.text ?? "")
        crossButton.isHidden = true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        crossButton.isHidden = false
    }
}

// MARK: - Keyboard Notification

/// LoginViewController
extension LoginViewController {
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShowHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShowHide),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShowHide(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let animationDuration = (
                userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]
                    as? NSNumber
            )?.doubleValue else { return }

        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue

        if notification.name == UIResponder.keyboardWillHideNotification {
            bottomConstraint?.constant = -75
        } else {
            bottomConstraint?.constant = -keyboardScreenEndFrame.height - 5
        }

        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}
