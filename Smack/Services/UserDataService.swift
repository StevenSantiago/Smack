//
//  UserDataService.swift
//  Smack
// Used to store user data returned from login API
//  Created by Steven on 10/10/18.
//  Copyright © 2018 Steven Santiago. All rights reserved.
//

import Foundation

class UserDataService{
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""//[0.5,0.5,0.5,1]
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String,avatarColor: String, avatarName: String, email: String, name: String){
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    // Used to set AvatarName after intial login
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    func returnUIColor(components: String) -> UIColor{
        //Default color in case cannot unwrap
        let defaultColor = UIColor.lightGray
        // set up scanner to parse through component passed in
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        //set characters to be skipped to scanner property
        scanner.charactersToBeSkipped = skipped
        
        var r,g,b,a : NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        guard let rUnwrap = r else{return defaultColor}
        guard let gUnwrap = g else{return defaultColor}
        guard let bUnwrap = b else{return defaultColor}
        guard let aUnwrap = a else{return defaultColor}
        
        let rfloat = CGFloat(rUnwrap.doubleValue)
        let gfloat = CGFloat(gUnwrap.doubleValue)
        let bfloat = CGFloat(bUnwrap.doubleValue)
        let afloat = CGFloat(aUnwrap.doubleValue)
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColor
    }
    
    func logOutUser(){
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
    }
}
