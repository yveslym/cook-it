//
//  RecipeServices.swift
//  cook-it
//
//  Created by Yves Songolo on 4/17/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation
import Moya

enum RecipeServices{
    case searchRecipe (query:String)
    case getRecipeInformation (id: Int)
    case anilyzedRecipe (id: Int)
    case recipeInformation(id: Int)
}

extension RecipeServices: TargetType{
    var baseURL: URL { return URL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/")! }
    
    var path: String {
        switch self{
            
        case .searchRecipe(_):
            return "recipes/search"
        case .getRecipeInformation(let id):
            return "recipes/\(id)/information"
        case .anilyzedRecipe(let id):
            return "recipes/\(id)/analyzedInstructions"
        case .recipeInformation(let id):
            return "recipes/\(id)/information"
        }
    }
    
    var method: Moya.Method {
        switch self{
            
        case .searchRecipe(_), .getRecipeInformation(_), .anilyzedRecipe(_), .recipeInformation(_):
            return .get
        }
    }
    
    var sampleData: Data {
        switch self{
            
        case .searchRecipe(_) , .getRecipeInformation(_), .anilyzedRecipe(_), .recipeInformation(_):
            return Data()
       
        }
    }
    
    var task: Task {
        switch self{
            
        case .getRecipeInformation(_):
            return .requestPlain
            
        case .searchRecipe(let query):
            return .requestParameters(parameters: ["query": query, "number": 20,"instructionsRequired":true], encoding: URLEncoding.queryString)
        
       
        case .anilyzedRecipe(_):
             return .requestParameters(parameters: ["stepBreakdown": true], encoding: URLEncoding.queryString)
        case .recipeInformation(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        
        switch self{
        case .searchRecipe(_), .getRecipeInformation(_), .anilyzedRecipe(_), .recipeInformation(_):
            
            return ["Content-type": "application/json", "X-RapidAPI-Key": ""]
       
        }
    }
}
