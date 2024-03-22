// Recipe+CoreDataProperties copy.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Рецепт для кеширования в кордату
public extension RecipeCD {
    @nonobjc class func fetchRequest() -> NSFetchRequest<RecipeCD> {
        NSFetchRequest<RecipeCD>(entityName: "RecipeCD")
    }

    @NSManaged var uri: String?
    @NSManaged var name: String?
    @NSManaged var dishType: String?
    @NSManaged var cookingTimeInMinutes: Int16
    @NSManaged var caloriesCount: Int16
    @NSManaged var weightGram: Int16
    @NSManaged var carbohydratesGram: Double
    @NSManaged var fatsGram: Double
    @NSManaged var proteinGram: Double
    @NSManaged var enercKcal: Int16
    @NSManaged var imageBase64: String?
    @NSManaged var imageUrl: String?
    @NSManaged var detailDescription: String?
}
