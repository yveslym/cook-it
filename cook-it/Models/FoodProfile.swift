//
//  FoodProfile.swift
//  cook-it
//
//  Created by Yves Songolo on 4/11/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation

struct FoodProfile: Codable{
    let diet: String
    let allergies: [String]
    let cuisines: [String]
}
