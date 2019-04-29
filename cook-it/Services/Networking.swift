//
//  Networking.swift
//  cook-it
//
//  Created by Yves Songolo on 4/21/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation
import Moya

struct Network: DecodeModel{
    
    /// Method to fetch data from food api
    public func FoodApi (service: RecipeServices, completionHandler: @escaping (Result<Any,Error>)->()){
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
                
                if let decoded = self.decodeFoodModel(service: service, data: data){
                    completionHandler(.success(decoded as Any))
                }
                else {
                    completionHandler(.failure(FoodError.cannotDecode))
                }
                
            }
        }
        
    }
}

