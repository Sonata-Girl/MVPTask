// UIColor+Extension+Flyweight .swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Быстрый доступ к загруженному цвету
let appMint = UIColor(named: "appMint")
/// Быстрый доступ к загруженному цвету
let appLightMint = UIColor(named: "appLightMint")
/// Быстрый доступ к загруженному цвету
let appLightGray = UIColor(named: "appLightGray")

/// Расширение для быстрого доступа к добавленным цветам
extension UIColor {
    static var colorStateMap: [String: UIColor] = [:]
    class func rgba(
        _ red: CGFloat,
        _ green: CGFloat,
        _ blue: CGFloat,
        _ alfa: CGFloat
    ) -> UIColor {
        let key = "\(red), \(green), \(blue), \(alfa)"
        if let color = colorStateMap[key] {
            return color
        }
        let color = UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: alfa
        )
        colorStateMap[key] = color
        return color
    }
}
