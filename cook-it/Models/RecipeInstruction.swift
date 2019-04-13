//
//  RecipeInstruction.swift
//  cook-it
//
//  Created by Yves Songolo on 4/11/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation

struct RecipeInstruction : Codable {
    let name: String?
    let steps: [CookingStep]?

}

struct CookingStep: Codable {
    let number: Int
    let step: String
    let ingredients: [Ingredient]?
    let equipment: [Equipment]?
    
}
struct CookingLengh: Codable{
    let number: Int
    let unit: String
}
