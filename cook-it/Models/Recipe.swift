//
//  Recipe.swift
//  cook-it
//
//  Created by Yves Songolo on 4/11/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation

struct Recipe: Codable{
    let id: Int
    let title: String
    var image: String 
    var imageUrl: URL?
    let calories: Int
    let protein: Int
    let fat: Int
    let readyInMinutes: Int
    let servings: Int
    let vegetarian: Bool?
    let vegan: Bool?
    let glutenFree: Bool?
    let dairyFree: Bool?
    let veryHealthy: Bool?
    let cheap: Bool?
    let sustainable: Bool?
    let cookingMinutes: Int?
    let healthScore: Int?
    let sourceName: String?
    let extendedIngredients: [Ingredient]?
    let instructions: String?
    let analyzedInstructions: [RecipeInstruction]?
    let diets: [String]?
    let occasions: [String]?
    let creditsText: String?
}
