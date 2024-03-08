// Logger.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class Logger {
    // MARK: Constants

    private enum Constants {
        static let logFileName = "RecipeLogFile.txt"
    }

    // MARK: Public Methods

    func addMessageToLog(_ message: String) {
        addLineToLog(message: message + " - \(Date()); \n")
    }

    // MARK: Private Methods

    private func addLineToLog(message: String) {
        guard let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return }

        let newFileName = Constants.logFileName
        let fileURL = documentsDirectory.appendingPathComponent(newFileName)

        if FileManager.default.fileExists(atPath: fileURL.path()) {
            do {
                if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
                    fileHandle.seekToEndOfFile()
                    if let data = message.data(using: .utf8) {
                        fileHandle.write(data)
                    }
                    fileHandle.closeFile()
                }
            }
        } else {
            do {
                try message.write(
                    toFile: fileURL.path,
                    atomically: true,
                    encoding: .utf8
                )
            } catch {
                print("error save file with error", error)
            }
        }
    }
}
