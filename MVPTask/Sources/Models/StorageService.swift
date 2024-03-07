// StorageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Мок данные для приложения. Имитация сети
final class StorageService {
    // MARK: Private Properties

    private var recipes: [Recipe] = []
    private var categories: [Category] = []
    private var user: User = .init(name: "Name", surname: "Surname", imageName: "userAvatar")

    // MARK: Initializers

    init() {
        fillTestSources()
    }

    // MARK: Public Methods

    func getUser() -> User {
        user
    }

    func getRecipes() -> [Recipe] {
        recipes
    }

    func getCategories() -> [Category] {
        categories
    }

    // MARK: Private Methods

    private func fillTestSources() {
        // Заполнение Категорий
        let categoryFish = Category(name: "fish", imageName: "recipe7")
        categories = [
            .init(name: "Salad", imageName: "salad"),
            .init(name: "Soup", imageName: "soup"),
            .init(name: "Chicken", imageName: "chicken"),
            .init(name: "Meat", imageName: "meat"),
            categoryFish,
            .init(name: "Side dish", imageName: "side dish"),
            .init(name: "Drinks", imageName: "drinks"),
            .init(name: "Pancake", imageName: "pancakes"),
            .init(name: "Desserts", imageName: "desserts")
        ]

        /// Recipe
        let recipe1 = Recipe(
            name: "Simple Fish And Corn",
            category: categoryFish,
            cookingTimeInMinutes: 60,
            caloriesCount: 274,
            weightGram: 700,
            carbohydratesGram: 10.78,
            fatsGram: 10.00,
            proteinGram: 97.30,
            enercKcal: 1322,
            imageName: "recipe1",
            detailDescription: getDescriptionForRecipe()
        )
        recipes.append(recipe1)

        let recipe2 = Recipe(
            name: "Baked Fish with Lemon Herb Sauce",
            category: categoryFish,
            cookingTimeInMinutes: 90,
            caloriesCount: 616,
            weightGram: 700,
            carbohydratesGram: 10.78,
            fatsGram: 10.00,
            proteinGram: 97.30,
            enercKcal: 1322,
            imageName: "recipe2",
            detailDescription: getDescriptionForRecipe()
        )
        recipes.append(recipe2)

        let recipe3 = Recipe(
            name: "Lemon and Chilli Fish Burrito",
            category: categoryFish,
            cookingTimeInMinutes: 90,
            caloriesCount: 226,
            weightGram: 700,
            carbohydratesGram: 10.78,
            fatsGram: 10.00,
            proteinGram: 97.30,
            enercKcal: 1322,
            imageName: "recipe3",
            detailDescription: getDescriptionForRecipe()
        )
        recipes.append(recipe3)

        let recipe4 = Recipe(
            name: "Fast Roast Fish & Show Peas Recipes",
            category: categoryFish,
            cookingTimeInMinutes: 80,
            caloriesCount: 94,
            weightGram: 700,
            carbohydratesGram: 10.78,
            fatsGram: 10.00,
            proteinGram: 97.30,
            enercKcal: 1322,
            imageName: "recipe4",
            detailDescription: getDescriptionForRecipe()
        )
        recipes.append(recipe4)

        let recipe5 = Recipe(
            name: "Salmon with Cantaloupe and Fried Shallots",
            category: categoryFish,
            cookingTimeInMinutes: 100,
            caloriesCount: 410,
            weightGram: 700,
            carbohydratesGram: 10.78,
            fatsGram: 10.00,
            proteinGram: 97.30,
            enercKcal: 1322,
            imageName: "recipe5",
            detailDescription: getDescriptionForRecipe()
        )
        recipes.append(recipe5)

        let recipe6 = Recipe(
            name: "Chilli and Tomato Fish",
            category: categoryFish,
            cookingTimeInMinutes: 100,
            caloriesCount: 174,
            weightGram: 700,
            carbohydratesGram: 10.78,
            fatsGram: 10.00,
            proteinGram: 97.30,
            enercKcal: 1322,
            imageName: "recipe6",
            detailDescription: getDescriptionForRecipe()
        )
        recipes.append(recipe6)

        let recipe7 = Recipe(
            name: "Chilli and Tomato Fish",
            category: categoryFish,
            cookingTimeInMinutes: 90,
            caloriesCount: 174,
            weightGram: 700,
            carbohydratesGram: 10.78,
            fatsGram: 10.00,
            proteinGram: 97.30,
            enercKcal: 1322,
            imageName: "recipe6",
            detailDescription: getDescriptionForRecipe()
        )
        recipes.append(recipe7)
    }

    private func getDescriptionForRecipe() -> String {
        """
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium size asian eggplants, cut int 1 inch rounds
        Handful of bird's eye chilies
        1/2 cup thai basil leaves
        Juice of 3 limes
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium size asian eggplants, cut int 1 inch rounds
        Handful of bird's eye chilies
        1/2 cup thai basil leaves
        Juice of 3 limes
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium size asian eggplants, cut int 1 inch rounds
        Handful of bird's eye chilies
        1/2 cup thai basil leaves
        Juice of 3 limes
        """
    }

    func getDescriptionTerms() -> String {
        """
        Welcome to our recipe app! We're thrilled to have you on board. 
        To ensure a delightful experience for everyone, please take a moment to familiarize yourself with our rules:
        User Accounts:
        • Maintain one account per user.
        • Safeguard your login credentials; don't share them with others.
        Content Usage:
        • Recipes and content are for personal use only.
        • Do not redistribute or republish recipes without proper attribution.
        Respect Copyright:
        • Honor the copyright of recipe authors and contributors.
        • Credit the original source when adapting or modifying a recipe.
        Community Guidelines:
        • Show respect in community features.
        • Avoid offensive language or content that violates community standards.
        Feedback and Reviews:
        • Share constructive feedback and reviews.
        • Do not submit false or misleading information.
        Data Privacy:
        • Review and understand our privacy policy regarding data collection and usage.
        Compliance with Laws:
        • Use the app in compliance with all applicable laws and regulations.
        Updates to Terms:
        • Stay informed about updates; we'll notify you of any changes.
        By using our recipe app, you agree to adhere to these rules.
        Thank you for being a part of our culinary community! Enjoy exploring and cooking up a storm!
        """
    }
}
