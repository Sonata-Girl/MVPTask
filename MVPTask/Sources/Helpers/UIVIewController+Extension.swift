// UIVIewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для универсальных алертов
extension UIViewController {
    /// - Parameters:
    ///     - title: Заголовок alert
    ///     - defaultButtonTitle: Заголовок кнопки по умолчанию
    ///     - hasCancel: Имеется кнопка Cancel в алерте
    ///     - completion: Блок выполнения
    /// Алерт для показа информации c кнопкой ok и действием для нее
    func showAlert(
        title: String,
        defaultButtonTitle: String = "Ok",
        hasCancel: Bool,
        completion: (() -> ())? = nil
    ) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: defaultButtonTitle, style: .default) { _ in
            completion?()
        }
        alertController.addAction(actionOk)

        if hasCancel {
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(actionCancel)
        }

        present(alertController, animated: true)
    }

    /// - Parameters:
    ///     - title: Заголовок alert
    ///     - defaultButtonTitle: Заголовок кнопки по умолчанию
    ///     - hasCancel: Имеется кнопка Cancel в алерте
    ///     - completion: Блок выполнения
    /// Алерт для показа информации c кнопкой ok и действием для нее
    func showInputAlert(
        title: String,
        placeHolder: String,
        completion: @escaping (String) -> Void
    ) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in
            guard
                let inputText = alertController.textFields?.first?.text,
                !inputText.isEmpty
            else { return }
            completion(inputText)
        }
        alertController.addAction(actionOk)

        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(actionCancel)

        alertController.addTextField { textField in
            textField.placeholder = placeHolder
            textField.font = .systemFont(ofSize: 16)
        }

        present(alertController, animated: true)
    }
}
