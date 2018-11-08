//
//  LoginVC.swift
//  Smack
//
//  Created by Steven on 10/4/18.
//  Copyright © 2018 Steven Santiago. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = userName.text , userName.text != ""
            else{return}
        
        guard let pass = passWord.text , passWord.text != ""
            else{return}
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    func setUpView(){
        spinner.isHidden = true
        userName.attributedPlaceholder = NSAttributedString(string: "username", attributes: [.foregroundColor: smackPurplePlaceHolder])
        passWord.attributedPlaceholder = NSAttributedString(string: "password", attributes: [.foregroundColor: smackPurplePlaceHolder])
        
    
    }
    
}
