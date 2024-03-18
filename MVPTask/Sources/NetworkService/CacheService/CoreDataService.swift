// CoreDataService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation
import UIKit

/// Сервис для кеширования рецептов
final class CoreDataService: NSObject {
    // MARK: Constants

    private enum Constants {
        static let entityName = "RecipeCD"
        static let corDataModelName = "MVPTaskCoreData"
    }

    // MARK: Public Properties

    static let shared = CoreDataService()

    // MARK: Private Properties

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }

    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    private var backgroundContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.corDataModelName)
        container.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("DB url -", description.url?.absoluteString ?? "")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    // MARK: Initializers

    override private init() {}

    // MARK: Public Methods

    func logCoreDataDBPath() {
        if let url = persistentContainer.persistentStoreCoordinator.persistentStores.first?.url {
            print("DB url -", url)
        }
    }

    func createRecipe(recipe: Recipe) {
        guard let recipeEntity = NSEntityDescription.entity(
            forEntityName: Constants.entityName,
            in: context
        ) else { return }
        let recipeCD = RecipeCD(entity: recipeEntity, insertInto: context)
        recipeCD.uri = recipe.uri
        recipeCD.name = recipe.name
        recipeCD.dishType = recipe.dishType.first ?? ""
        recipeCD.imageUrl = recipe.imageUrl
        recipeCD.detailDescription = recipe.detailDescription
        recipeCD.imageBase64 = recipe.imageBase64
        recipeCD.caloriesCount = Int16(recipe.caloriesCount)
        recipeCD.carbohydratesGram = recipe.carbohydratesGram
        recipeCD.cookingTimeInMinutes = Int16(recipe.cookingTimeInMinutes)
        recipeCD.fatsGram = recipe.fatsGram
        recipeCD.weightGram = Int16(recipe.weightGram)
        recipeCD.proteinGram = recipe.proteinGram
        recipeCD.enercKcal = Int16(recipe.enercKcal)
        saveContext()
    }

    func fetchRecipes(
        dishType: String,
        qParameter: String,
        health: String
    ) -> [RecipeCD] {
        let fetchRequest = RecipeCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "dishType ==[c] %@ AND name CONTAINS %@",
            dishType,
            qParameter,
            health
        )

        do {
            return try backgroundContext.fetch(fetchRequest)
        } catch {
            print("Error fetching recipes: \(error)")
            return []
        }
    }

    func fetchRecipe(with uri: String) -> RecipeCD? {
        let fetchRequest = RecipeCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uri == %@", uri)
        do {
            let photos = try? context.fetch(fetchRequest)
            return photos?.first
        }
    }

    func updateRecipe(with uri: String, newValueName: String? = nil) {
        let fetchRequest = RecipeCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uri == %@", uri)
        do {
            guard let recipes = try? context.fetch(fetchRequest),
                  let recipe = recipes.first else { return }
            recipe.name = newValueName
        }

        saveContext()
    }

    func deleteAllRecipe(dishType: String) {
        let fetchRequest = RecipeCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "dishType ==[c] %@", dishType)

        do {
            let photos = try? context.fetch(fetchRequest)
            photos?.forEach { context.delete($0) }
        }

        saveContext()
    }

    func deleteRecipe(uri: String) {
        let fetchRequest = RecipeCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uri == %@", uri)
        do {
            guard let photos = try? context.fetch(fetchRequest),
                  let photo = photos.first else { return }
            context.delete(photo)
        }

        saveContext()
    }

    // MARK: Private Methods

    private func saveContext() {
        context.performAndWait {
            if self.context.hasChanges {
                do {
                    try self.context.save()
                } catch {
                    self.context.rollback()
                }
            }
            self.context.reset()
        }
    }
}
