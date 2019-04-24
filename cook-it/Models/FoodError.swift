//
//  FoodError.swift
//  cook-it
//
//  Created by Yves Songolo on 4/22/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation

struct FoodErrorModel: Decodable, Error{
    let status: String
    let code: Int
    let message: String
}
enum FoodError: Error{
    
    case cannotDecode
    case noDataToDecode
}
