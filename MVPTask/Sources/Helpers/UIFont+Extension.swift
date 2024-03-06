// UIFont+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрого доступа к добавленным шрифтам
extension UIFont {
    /// Получение шрифта Verdana  с размером
    /// - Parameter withSize: Размер шрифта
    /// - Returns: Шрифт Verdana
    static func addVerdanaBold(withSize: CGFloat) -> UIFont? {
        addFont("Verdana-Bold", withSize)
    }

    /// Получение шрифта Verdana полужирный  с размером
    /// - Parameter withSize: Размер шрифта
    /// - Returns: Шрифт Verdana-Bold
    static func addVerdana(withSize: CGFloat) -> UIFont? {
        addFont("Verdana", withSize)
    }

    /// Получение шрифта Verdana  полужирный курсив с размером
    /// - Parameter withSize: Размер шрифта
    /// - Returns: Шрифт Verdana-BoldItalic
    static func addVerdanaBoldItalic(withSize: CGFloat) -> UIFont? {
        addFont("Verdana-BoldItalic", withSize)
    }

    static var fontStateMap: [String: UIFont] = [:]
    class func addFont(_ name: String, _ size: CGFloat) -> UIFont {
        let key = "\(name), \(size)"
        if let font = fontStateMap[key] {
            return font
        }
        let font = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
        fontStateMap[key] = font
        return font
    }
}
