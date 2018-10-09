//
//  Constants.swift
//  Smack
//
//  Created by Steven on 10/4/18.
//  Copyright © 2018 Steven Santiago. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> () // Create Closure names as CompletionHandler

//URL Constants
let BASE_URL = "https://smackiphone.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

//User defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

