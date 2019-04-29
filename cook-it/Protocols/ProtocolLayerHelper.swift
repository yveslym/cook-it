//
//  ProtocolLayerHelper.swift
//  cook-it
//
//  Created by Yves Songolo on 4/28/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation

protocol DecodeModel: Codable{
    //func decodeMe<T: Decodable>(type: T? , data: Data) -> T?
}



extension DecodeModel {
   
    fileprivate func decodeMe<T: Decodable>(type: T?,data: Data) -> T?{
        do{
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
        }
        catch {
            return nil
        }
    }
    public func decodeFoodModel (service: RecipeServices, data: Data) -> Any? {
        
        switch service {
            
        case .searchRecipe(_):
            let decoderType = SearchRecipeResult()
            if let searchResult = decodeMe(type: decoderType, data: data){
                return searchResult.results as Any
            }else { return nil }
        case .getRecipeInformation(_):
           return nil
        case .anilyzedRecipe(_):
            
            let decodeType = [RecipeInstruction]()
            if let instruct = decodeMe(type: decodeType, data: data){
               return instruct as Any
            }
            else {return nil}
            
        case .recipeInformation(_):
            let decodeType = Recipe.init(id: 0, title: "", calories: 0, protein: 0, fat: 0, readyInMinutes: 0, servings: 0, vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, veryHealthy: false, cheap: false, sustainable: false, cookingMinutes: 0, healthScore: 0, sourceName: "", extendedIngredients: nil, instructions: "", analyzedInstructions: nil, diets: nil, occasions: nil, creditsText: "", imageUrls: nil)
            if let decoded = decodeMe(type: decodeType, data: data){
                return decoded as Any
            }
            else {
                return nil
            }
        }
    }
}
