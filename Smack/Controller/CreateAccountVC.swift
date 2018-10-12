//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Steven on 10/4/18.
//  Copyright © 2018 Steven Santiago. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var userEmailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    //Default Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePressed(_ sender: Any){
        performSegue(withIdentifier: UNWIND, sender: nil)
    }

    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        // using guards to safely unwrap text field
        guard let name = userNameTxt.text, userEmailTxt.text != ""
            else {return}
        guard let email = userEmailTxt.text, userEmailTxt.text != ""
            else{return}
        guard let pass = passTxt.text, passTxt.text != ""
            else{return}
        // Once email and pass unwrap pass them into register user
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success{ // If register User comes back successfull then login user
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success{
                                print(UserDataService.instance.name)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)// Go back to home view.
                            }
                        })
                    }
                })
            }
        }
    }
    
}
