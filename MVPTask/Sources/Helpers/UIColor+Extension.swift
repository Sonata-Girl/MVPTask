// UIColor+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрого доступа к добавленным цветам
extension UIColor {
    /// Храненилище созданных цветов
    static var colorStoreMap: [String: UIColor] = [:]

    /// Быстрый доступ к загруженному цвету appMint
    var appMint: UIColor? {
        UIColor(named: "appMint") ?? nil
    }

    /// Быстрый доступ к загруженному цвету appLightMint
    var appLightMint: UIColor? {
        UIColor(named: "appLightMint") ?? nil
    }

    /// Быстрый доступ к загруженному цвету appLightGray
    var appLightGray: UIColor? {
        UIColor(named: "appLightGray") ?? nil
    }

    /// Получение цвета по rgb
    class func rgba(
        _ red: CGFloat,
        _ green: CGFloat,
        _ blue: CGFloat,
        _ alpha: CGFloat
    ) -> UIColor {
        let key = "\(red)\(green)\(blue)\(alpha)"
        if let color = colorStoreMap[key] {
            return color
        }

        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        colorStoreMap[key] = color
        return color
    }
}
