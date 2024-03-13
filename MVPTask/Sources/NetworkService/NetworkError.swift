// NetworkError.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Описание ошибок сети
enum NetworkError: Error {
    case errorRequest
    case invalidResponceCode
    case decodedProblem
    case getDataProblem
    case error(message: String)

    public var description: String {
        switch self {
        case .errorRequest: return "Can't get answer from api"
        case .invalidResponceCode: return "Server back failure code"
        case .decodedProblem: return "Decoded problem from server"
        case .getDataProblem: return "Can't get data"
        case let .error(message): return"\(message)"
        }
    }
}
