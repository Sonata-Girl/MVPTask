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
        completion: @escaping (
            Result<[Recipe]?, Error>
        ) -> Void
    )

    /// Получение рецепта
    /// - Parameters:
    ///     - uri: Адрес рецепта для параметра
    ///     - completion: Блок выполнения
    /// - Returns: Рецепт
    func getRecipe(
        uri: String,
        completion: @escaping (
            Result<Recipe?, Error>
        ) -> Void
    )
}

/// Сервис для получения данных из сети
final class NetworkService: NetworkServiceProtocol {
    // MARK: Private Properties

    private let jsonDecoder = JSONDecoder()
    private let requestBuilder = RequestBuilder()

    // MARK: Public Methods

    func getRecipes(
        categoryName: String,
        qParameter: String,
        completion: @escaping (
            Result<[Recipe]?, Error>
        ) -> Void
    ) {
        guard let request = requestBuilder.makeCategoryRecipeRequest(
            categoryName: categoryName,
            qParameter: qParameter
        ) else { return }
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                guard let data else { return }
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
                completion(.failure(error))
            }
        }.resume()
    }

    func getRecipe(
        uri: String,
        completion: @escaping (
            Result<Recipe?, Error>
        ) -> Void
    ) {
        guard let request = requestBuilder.makeCategoryRecipeRequest(uri: uri) else { return }
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                guard let data else { return }
                self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

                var recipesDTO = try self.jsonDecoder.decode(RecipesDTO.self, from: data)

                guard var recipeDto = recipesDTO.hits.first else {
                    return completion(.failure(NSError(domain: "Не удалось получить рецепт", code: 0, userInfo: nil)))
                }
                if let imageURL = URL(string: recipeDto.recipe.image), let data = try? Data(contentsOf: imageURL) {
                    recipeDto.recipe.imageBase64 = data.base64EncodedString()
                }
                completion(.success(Recipe(dto: recipeDto.recipe)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
