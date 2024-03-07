// LoggerInvoker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Функция для записи логов
public func log(_ action: LogAction) {
    let command = LogCommand(action: action)
    LoggerInvoker.shared.addLogCommand(command)
}

final class LoggerInvoker {
    // MARK: Singleton

    static let shared = LoggerInvoker()

    // MARK: Private Properties

    private let logger = Logger()

    private var commands: [LogCommand] = []

    // MARK: Public Methods

    func addLogCommand(_ command: LogCommand) {
        commands.append(command)
        executeCommandsIfNeeded()
    }

    // MARK: Private Methods

    private func executeCommandsIfNeeded() {
        commands.forEach { self.logger.addMessageToLog($0.logMessage) }
        commands = []
    }
}
