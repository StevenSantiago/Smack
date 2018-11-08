//
//  ChatVC.swift
//  Smack
//
//  Created by Steven on 10/3/18.
//  Copyright © 2018 Steven Santiago. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //Outlet
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)// add custom action from SWRevealViewController
        
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)// Functionality to slide menu out and in
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)// Functionality to tap menu back in
        // Do any additional setup after loading the view.
        
        //Checks if user is already logged in
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }
    

  

}
