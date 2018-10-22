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
    
    @IBOutlet weak var creatingAccountLoad: UIActivityIndicatorView!
    
    //Default Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    var bgColor : UIColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
        //Turning background color to light gray if not background is selected
        if avatarName.contains("light") && bgColor == nil {
            userImg.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func closePressed(_ sender: Any){
        performSegue(withIdentifier: UNWIND, sender: nil)
    }

    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        //Generating random numbers for RGB values
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        UIView.animate(withDuration: 0.25) {
            self.userImg.backgroundColor = self.bgColor
        }
        
    }
    
    func setUpView(){
        //Changing the color of placeholder, Interface builder does not allow for this
        creatingAccountLoad.isHidden = true
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [.foregroundColor: smackPurplePlaceHolder])
        userEmailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [.foregroundColor: smackPurplePlaceHolder])
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [.foregroundColor: smackPurplePlaceHolder])
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        // using guards to safely unwrap text field
        creatingAccountLoad.isHidden = false
        creatingAccountLoad.startAnimating()
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
                                self.creatingAccountLoad.isHidden = true
                                self.creatingAccountLoad.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)// Go back to home view.
                                //Set up notification center post for listeners to look for
                            NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
}
