//
//  User.swift
//  cook-it
//
//  Created by Yves Songolo on 4/11/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation

struct User: Codable {

    let firstName: String
    let lastName: String
    let username: String
    var id: String
    
    private static var _current: User?
    static var current: User?{
        
        // check if user exist
        if let currentUser = _current{
            return currentUser
        }
        else{
            // decode into user
            guard let data = UserDefaults.standard.value(forKey: "current") as? Data else { return nil}
            let user = try! JSONDecoder().decode(User.self, from: data)
            
            //return user
            return user
        }
    }
    /// Function to set and save the current user of the app to UserDefaults
    static func setCurrentUser(user: User, writeToUserDefaults: Bool = false){
        
        if writeToUserDefaults{
            if let data = try? JSONEncoder().encode(user){
                UserDefaults.standard.set(data, forKey: "current")
            }
        }
        _current = user
    }
}

enum UserError: Error{
    case userDoesNotExit
    case couldnotretrieveuser
    case couldnotdecodeUser
    case errorWhileSavingUser
    case couldNotloginUserAnonymously
}
