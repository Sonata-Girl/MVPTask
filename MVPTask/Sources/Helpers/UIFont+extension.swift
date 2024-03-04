// UIFont+extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрого доступа к добавленным шрифтам
extension UIFont {
    /// Хранение созданных шрифтов
    static var fontStoreMap: [String: UIFont] = [:]

    /// Получение шрифта Verdana полужирный  с размером
    /// - Parameter withSize: Размер шрифта
    /// - Returns: Шрифт Verdana-Bold
    static func setVerdanaBold(withSize: CGFloat) -> UIFont? {
        let key = "Verdana-Bold\(withSize)"
        if let font = fontStoreMap[key] {
            return font
        }

        guard let font = UIFont(name: "Verdana-Bold", size: withSize) else { return nil }
        fontStoreMap[key] = font
        return font
    }

    /// Получение шрифта Verdana  с размером
    /// - Parameter withSize: Размер шрифта
    /// - Returns: Шрифт Verdana
    static func setVerdana(withSize: CGFloat) -> UIFont? {
        let key = "Verdana\(withSize)"
        if let font = fontStoreMap[key] {
            return font
        }

        guard let font = UIFont(name: "Verdana", size: withSize) else { return nil }
        fontStoreMap[key] = font
        return font
    }

    /// Получение шрифта Verdana  полужирный курсив с размером
    /// - Parameter withSize: Размер шрифта
    /// - Returns: Шрифт Verdana-BoldItalic
    static func setVerdanaBoldItalic(withSize: CGFloat) -> UIFont? {
        let key = "Verdana-BoldItalic\(withSize)"
        if let font = fontStoreMap[key] {
            return font
        }

        guard let font = UIFont(name: "Verdana-BoldItalic", size: withSize) else { return nil }
        fontStoreMap[key] = font
        return font
    }
}
