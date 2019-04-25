//
//  UserService.swift
//  cook-it
//
//  Created by Yves Songolo on 4/24/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation
import Firebase

struct UserService{
    /// signIn user Anonymusly
    func signIn (_ user: User, completion: @escaping(Result<User,UserError>)->()){
        
        Auth.auth().signInAnonymously() { (authResult, error) in
            
            if error != nil {
                return completion(.failure(.couldNotloginUserAnonymously))
            }
            let authUser = authResult!.user
            var newUser = user
            newUser.id = authUser.uid
            
            self.saveUserInfo(newUser, completionHandler: { (err) in
                if error != nil {
                   let err = error as! UserError
                    return completion(.failure(err))
                }
            })
        }
    }
    
    /// Method to save new created user
    fileprivate func saveUserInfo(_ user: User, completionHandler: @escaping (UserError?)->()){
       let ref = Database.database().reference().child("Users").child(user.id)
        do{
             let userObj = try JSONEncoder().encodeJSONObject(user, options: [])
            
            // save user info
            ref.setValue(userObj) { (err, _) in
                
                switch err == nil{
                case true:
                    User.setCurrentUser(user: user, writeToUserDefaults: true)
                    completionHandler(nil)
                case false:
                    completionHandler(.errorWhileSavingUser)
                }
            }
        }
        catch{
             completionHandler(.couldnotdecodeUser)
        }
        
    }
    
    func getUser (_ id: String, completionHandler: @escaping (Result <User, UserError>)->()){
        let ref = Database.database().reference().child("Users").child(id)
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if !snapshot.exists() {
                return completionHandler(.failure(.userDoesNotExit))
            }
            do {
              
                let user = try JSONDecoder().decode(User.self, withJSONObject: snapshot.value!, options: [])
                return completionHandler(.success(user))
            }
            catch {
                return completionHandler(.failure(.couldnotdecodeUser))
            }
        }
    }
}



