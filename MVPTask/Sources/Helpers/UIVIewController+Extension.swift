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
    func showQuestionAlert(
        title: String,
        defaultButtonTitle: String,
        hasCancel: Bool,
        completion: @escaping () -> ()
    ) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: defaultButtonTitle, style: .default) { _ in
            completion()
        }
        alertController.addAction(actionOk)

        if hasCancel {
            let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
            alertController.addAction(actionCancel)
        }

        present(alertController, animated: true)
    }
}
