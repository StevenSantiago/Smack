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
}
