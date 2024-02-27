// UIFont+extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрого доступа к добавленным шрифтам
extension UIFont {
    /// Получение шрифта Verdana полужирный  с размером
    /// - Parameter withSize: Размер шрифта
    /// - Returns: Шрифт Verdana-Bold
    static func setVerdanaBold(withSize: CGFloat) -> UIFont? {
        UIFont(name: "Verdana-Bold", size: withSize)
    }

    /// Получение шрифта Verdana  с размером
    /// - Parameter withSize: Размер шрифта
    /// - Returns: Шрифт Verdana
    static func setVerdana(withSize: CGFloat) -> UIFont? {
        UIFont(name: "Verdana", size: withSize)
    }

    /// Получение шрифта Verdana  полужирный курсив с размером
    /// - Parameter withSize: Размер шрифта
    /// - Returns: Шрифт Verdana-BoldItalic
    static func setVerdanaBoldItalic(withSize: CGFloat) -> UIFont? {
        UIFont(name: "Verdana-BoldItalic", size: withSize)
    }
}
