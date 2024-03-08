// LogCommand.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Действия пользователя
public enum LogAction {
    /// Открыл экран
    case openScreen(screenName: String)
    /// Перешел к экрану
    case goToScreen(screenName: String, title: String = "")
    /// Открыл рецепт
    case openRecipe(recipeName: String)
    /// Поделился рецептом
    case shareRecipe(recipeName: String)
}

/// Функция для записи логов
public func log(_ action: LogAction) {
    let command = LogCommand(action: action)
    LoggerInvoker.shared.addLogCommand(command)
}

final class LogCommand {
    // MARK: Private Properties

    private let action: LogAction

    var logMessage: String {
        switch action {
        case let .openScreen(screenName):
            return "Пользователь открыл \(screenName)"
        case let .goToScreen(screenName, title):
            var text = "Пользователь перешел на \(screenName)"
            text += title.isEmpty ? "" : " из \(title)"
            return text
        case let .openRecipe(recipeName):
            return "Пользователь открыл рецепт блюда из \(recipeName)"
        case let .shareRecipe(recipeName):
            return "Пользователь поделился рецептом из \(recipeName)"
        }
    }

    // MARK: Initializers

    init(action: LogAction) {
        self.action = action
    }
}
