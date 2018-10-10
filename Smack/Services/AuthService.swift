//
//  AuthService.swift
//  Smack
// Handles variables
//  Created by Steven on 10/8/18.
//  Copyright © 2018 Steven Santiago. All rights reserved.
//

import Foundation
import Alamofire // helps with web requests, built on URLSession framework
import SwiftyJSON // helps with JSON handling, gets rid of casting and unwrapping

class AuthService{
    static let instance = AuthService() // Will be singleton
    
    let defaults = UserDefaults.standard// Used to save key value pairs and persist across app launches
    
    var isLoggedIn: Bool{
        get{
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String{
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue,forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let header = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        //Make a web request with the built parameter and URL. Capture response and pass true to completion handler
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString
            { (response) in
                if response.result.error == nil {
                    completion(true)
                } else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()

        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON {
            (response) in
            if response.result.error == nil {
                //Take response value and read as dictionary, typical way without libary to read JSON
//                if let json = response.result.value as? Dictionary<String,Any> {
//                    if let email = json["user"] as? String{
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
//                }
                
                //Using SwiftyJSON
                guard let data = response.data else{
                    return
                }
                //grab JSON object, can fail so pu in do catch block
                do{
                    let json = try JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    self.isLoggedIn = true
                } catch{
                    debugPrint("Error converting to JSON object")
                }
                
                
                //Can also use guards and chain to do the same as above
//                guard let data = response.data,
//                    let json = try? JSON(data: data) else {return}
//                self.userEmail = json["user"].stringValue
//                self.authToken = json["token"].stringValue
//                self.isLoggedIn = true
                completion(true)
            } else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
}
