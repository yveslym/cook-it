//
//  Helpers.swift
//  cook-it
//
//  Created by Yves Songolo on 4/11/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation

enum ImageBaseLink {

    /// image size and imge link
    case ingredient (ImageSize,String)
    /// image size and image link
    case equipment (ImageSize, String)
    /// image size and image id
    case recipe (RecipeImageSize, Int)

    var imageLink: String {
        switch self{

        case .ingredient(let imageSize, let image):
            return "https://spoonacular.com/cdn/ingredients\(imageSize)\(image)"
        case .equipment(let imageSize, let image):
            return "https://spoonacular.com/cdn/equipment\(imageSize)/\(image)"
        case .recipe(let imageSize, let id):
            return "https://spoonacular.com/recipeImages/\(id)\(imageSize.size).jpg"
        }
    }
}

enum ImageSize: String {
    case _100x100 = "_100x100/"
    case _250x250 = "_250x250/"
    case _500x500 = "_500x500/"
}
enum RecipeImageSize {
    case small
   
    case medium
   
    case large 
    
    var size: String {
        
        switch self{
            
        case .small:
            return  "-90x90"
        case .medium:
            return "-480x360"
        case .large:
            return "-636x393"
        }
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
