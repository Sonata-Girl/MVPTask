// NetworkError.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Описание ошибок сети
enum NetworkError: Error {
    /// Ошибка получения ответа от апи
    case errorRequest
    /// Сервер вернул неуспешный код ответа
    case invalidResponseCode
    /// Проблема в декодировании ответа
    case decodedProblem
    /// Ошибка получения данных
    case getDataProblem
    /// Другие ошибки, описание ошибки
    case error(message: String)

    public var description: String {
        switch self {
        case .errorRequest: return "Can't get answer from api"
        case .invalidResponseCode: return "Server back failure code"
        case .decodedProblem: return "Decoded problem from server"
        case .getDataProblem: return "Can't get data"
        case let .error(message): return"\(message)"
        }
    }
}
