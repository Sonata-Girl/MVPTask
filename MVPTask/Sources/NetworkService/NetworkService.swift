// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol NetworkServiceProtocol {
    func getRecipes(
        categoryName: String,
        qParameter: String,
        completion: @escaping (
            Result<[Recipe]?, Error>
        ) -> Void
    )
}

final class NetworkService: NetworkServiceProtocol {
    private let jsonDecoder = JSONDecoder()

    private var component = URLComponents()
    private var scheme = "https"
    private var host = "api.edamam.com"
    private var path = "/api/recipes/v2"
    private var queryItems: [URLQueryItem] = [
        .init(name: "type", value: "public"),
        .init(name: "app_id", value: "92ffabec"),
        .init(name: "app_key", value: "c57834e6ab65957628fd02601f8b92bd")
    ]

    func getRecipes(
        categoryName: String,

        qParameter: String,
        completion: @escaping (
            Result<[Recipe]?, Error>
        ) -> Void
    ) {
        var urlComponent = component
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = queryItems
        urlComponent.queryItems?.append(URLQueryItem(name: "dishType", value: "\(categoryName)"))
        urlComponent.queryItems?.append(URLQueryItem(name: "q", value: "\(qParameter)"))

        guard let url = urlComponent.url else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                guard let data else { return }
                self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

                var recipesDto = try self.jsonDecoder.decode(RecipesDto.self, from: data)
                for (index, hit) in recipesDto.hits.enumerated() {
                    if let imageURL = URL(string: hit.recipe.image), let data = try? Data(contentsOf: imageURL) {
                        recipesDto.hits[index].recipe.imageBase64 = data.base64EncodedString()
                    }
                }
                let recipes = recipesDto.hits.map {
                    Recipe(dto: $0.recipe)
                }

                completion(.success(recipes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
