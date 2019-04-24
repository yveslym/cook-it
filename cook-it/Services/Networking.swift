//
//  Networking.swift
//  cook-it
//
//  Created by Yves Songolo on 4/21/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation
import Moya

struct Network{
    static func FoodApi(service: RecipeServices, completionHandler: @escaping (Result<Any,Error>)->()){
        let provider = MoyaProvider<RecipeServices>()
        provider.request(service) { (result) in
            switch result{
            case .failure(let err):
                return completionHandler(.failure(err))
                
            case .success(let response):
                if response.statusCode > 201 {
                    do {
                        let error = try JSONDecoder().decode(FoodErrorModel.self, from: response.data)
                        return completionHandler(.failure(error))
                    }
                    catch{
                        return completionHandler(.failure(FoodError.cannotDecode))
                    }
                }
                let data = response.data
                switch service{
                    
                case .searchRecipe(_):
                   
                    do {
                    let recipes = try JSONDecoder().decode(SearchRecipeResult.self, from: data)
                    return completionHandler(.success(recipes.results))
                    }
                    catch{
                         return completionHandler(.failure(FoodError.cannotDecode))
                    }
                    
                case .getRecipeInformation(_):
                    return completionHandler(.failure(FoodError.cannotDecode))
                    
                case .anilyzedRecipe(_):
                    
                    do{
                        let recipeInst = try JSONDecoder().decode([RecipeInstruction].self, from: data)
                        return completionHandler(.success(recipeInst))
                    }
                    catch{
                          return completionHandler(.failure(FoodError.cannotDecode))
                    }
                case .recipeInformation(_):
                    do{
                        let recipe = try JSONDecoder().decode(Recipe.self, from: data)
                        return completionHandler(.success(recipe))
                    }
                    catch{
                        return completionHandler(.failure(FoodError.cannotDecode))
                    }
                }
            }
        }
        
    }
}

