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
}

extension RecipeServices: TargetType{
    var baseURL: URL { return URL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/")! }
    
    var path: String {
        switch self{
            
        case .searchRecipe(_):
            return "recipes/search"
        case .getRecipeInformation(let id):
            return "recipes/\(id)/information"
        }
    }
    
    var method: Moya.Method {
        switch self{
            
        case .searchRecipe(_), .getRecipeInformation(_):
            return .get
        
        }
    }
    
    var sampleData: Data {
        switch self{
            
        case .searchRecipe(_) , .getRecipeInformation(_):
            return Data()
        }
    }
    
    var task: Task {
        switch self{
            
        case .searchRecipe(let query):
            return .requestParameters(parameters: ["query": query, "number": 20,"instructionsRequired":true], encoding: URLEncoding.queryString)
        
        case .getRecipeInformation(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        
        switch self{
        case .searchRecipe(_), .getRecipeInformation(_): return ["Content-type": "application/json"]
        }
    }
    

}
