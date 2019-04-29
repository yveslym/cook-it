//
//  Environment.swift
//  cook-it
//
//  Created by Yves Songolo on 4/28/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation

struct Environment {
    
    fileprivate var infoDict: [String: Any]{
        get {
            if let dict = Bundle.main.infoDictionary{
                return dict
            }
            else {
                fatalError("Plist file not found")
            }
        }
    }
    
    public func configuration(_ key: PlistKeys) -> String{
        switch key{
            
        case .rapidApiKey:
            return infoDict[PlistKeys.rapidApiKey.value] as! String
        case .basedFoodApiUrl:
            return infoDict[PlistKeys.basedFoodApiUrl.value] as! String
        }
    }
}

public enum PlistKeys{
    case rapidApiKey
    case basedFoodApiUrl
    
    var value: String{
        
        switch self {
            
        case .rapidApiKey:
            return "RapidApiKey"
        case .basedFoodApiUrl:
            return "RapidApiBaseUrl"
        }
    }
}
