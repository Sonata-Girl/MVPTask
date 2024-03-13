// RequestBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - Api settings

/// Описание сервиса апи
enum ApiType {
    case getRecipes
    case getRecipe

    var scheme: String { "https" }
    var host: String { "api.edamam.com" }

    var path: String {
        switch self {
        case .getRecipes:
            return "/api/recipes/v2"
        case .getRecipe:
            return "/api/recipes/v2/by-uri"
        }
    }

    var queryItems: [URLQueryItem] {
        [
            .init(name: "type", value: "public"),
            .init(name: "app_id", value: "92ffabec"),
            .init(name: "app_key", value: "c57834e6ab65957628fd02601f8b92bd")
        ]
    }

    var components: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components
    }
}

final class RequestBuilder {
    private let api = ApiType.self

    func makeCategoryRecipeRequest(categoryName: String, qParameter: String) -> URLRequest? {
        var components = api.getRecipes.components
        components.queryItems?.append(URLQueryItem(name: "dishType", value: categoryName))
        components.queryItems?.append(URLQueryItem(name: "q", value: qParameter))
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }

    func makeCategoryRecipeRequest(uri: String) -> URLRequest? {
        var components = api.getRecipe.components
        components.queryItems?.append(URLQueryItem(name: "uri", value: uri))
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
}
