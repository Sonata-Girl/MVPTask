// UIString+Exstension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение для проверки строки
extension String {
    /// Проверка правильности ввода почтового адреса
    /// - Returns: Bool
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

        let emailCheck = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailCheck.evaluate(with: self)
    }

    /// Проверка правильности ввода пароля
    /// - Returns: Bool
    func isValidPassword() -> Bool {
        let passwordRegEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,}$"

        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordCheck.evaluate(with: self)
    }
}
