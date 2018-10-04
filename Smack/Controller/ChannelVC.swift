//
//  ChannelVC.swift
//  Smack
//
//  Created by Steven on 10/3/18.
//  Copyright © 2018 Steven Santiago. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
    }


}

