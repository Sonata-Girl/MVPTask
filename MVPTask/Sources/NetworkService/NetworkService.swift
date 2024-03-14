// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс сервиса для получения данных из сети
protocol NetworkServiceProtocol {
    /// Получение рецептов
    /// - Parameters:
    ///     - categoryName: Имя категории рецептов
    ///     - qParameter: параметр для получения категорий типа  Chicken Meat Fish Side Dish
    ///     - completion: Блок выполнения
    /// - Returns: Список рецептов в комплишне
    func getRecipes(
        categoryName: String,
        qParameter: String,
        completion: @escaping HandlerRecipes
    )

    /// Получение рецепта
    /// - Parameters:
    ///     - uri: Адрес рецепта для параметра
    ///     - completion: Блок выполнения
    /// - Returns: Рецепт
    func getRecipe(
        uri: String,
        completion: @escaping HandlerRecipe
    )
}

typealias HandlerRecipes = (Result<[Recipe], NetworkError>) -> Void
typealias HandlerRecipe = (Result<Recipe, NetworkError>) -> Void

/// Сервис для получения данных из сети
final class NetworkService: NetworkServiceProtocol {
    // MARK: Private Properties

    private let session = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    private let requestBuilder = RequestBuilder()

    // MARK: Public Methods

    func getRecipes(
        categoryName: String,
        qParameter: String,
        completion: @escaping HandlerRecipes
    ) {
        guard let url = requestBuilder.makeCategoryRecipeRequest(
            categoryName: categoryName,
            qParameter: qParameter
        )?.url else { return }

        session.dataTask(with: url) { result in
            switch result {
            case let .failure(error):
                completion(.failure(.error(message: error.localizedDescription)))
            case let .success(data):
                do {
                    self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    var recipesDTO = try self.jsonDecoder.decode(RecipesDTO.self, from: data)
                    for (index, hit) in recipesDTO.hits.enumerated() {
                        if let imageURL = URL(string: hit.recipe.image), let data = try? Data(contentsOf: imageURL) {
                            recipesDTO.hits[index].recipe.imageBase64 = data.base64EncodedString()
                        }
                    }
                    let recipes = recipesDTO.hits.map {
                        Recipe(dto: $0.recipe)
                    }
                    completion(.success(recipes))
                } catch {
                    completion(.failure(.decodedProblem))
                }
            }
        }.resume()
    }

    func getRecipe(
        uri: String,
        completion: @escaping HandlerRecipe
    ) {
        guard let url = requestBuilder.makeCategoryRecipeRequest(uri: uri)?.url else { return }
        session.dataTask(with: url) { result in
            switch result {
            case let .failure(error):
                completion(.failure(.error(message: error.localizedDescription)))
                return
            case let .success(data):
                do {
                    self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

                    let recipesDTO = try self.jsonDecoder.decode(RecipesDTO.self, from: data)

                    guard var recipeDto = recipesDTO.hits.first else {
                        return completion(.failure(.error(message: "Не найден рецепт")))
                    }
                    if let imageURL = URL(string: recipeDto.recipe.image), let data = try? Data(contentsOf: imageURL) {
                        recipeDto.recipe.imageBase64 = data.base64EncodedString()
                    }
                    completion(.success(Recipe(dto: recipeDto.recipe)))
                } catch {
                    completion(.failure(.decodedProblem))
                }
            }
        }.resume()
    }
}
