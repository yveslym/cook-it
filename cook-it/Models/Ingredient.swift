//
//  Ingredient.swift
//  cook-it
//
//  Created by Yves Songolo on 4/11/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation

struct Ingredient: Codable{
    let id:Int
    let aisle: String
    let image: String
    let consitency: String
    let name: String
    let originalString: String
    let amount: Double?
    let unit: String?
}

