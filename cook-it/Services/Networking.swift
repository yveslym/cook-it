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
                switch service{
                    
                case .searchRecipe(_):
                    let data = response.data
                    do {
                    let recipes = try JSONDecoder().decode([Recipe].self, from: data)
                    return completionHandler(.success(recipes))
                    }
                    catch{
                         return completionHandler(.failure(FoodError.cannotDecode))
                    }
                    
                case .getRecipeInformation(_):
                    return completionHandler(.failure(FoodError.cannotDecode))
                }
           
            }
        }
        
    }
}

enum FoodError: Error{
    case cannotDecode
}
