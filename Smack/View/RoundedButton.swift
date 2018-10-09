//
//  RoundedButton.swift
//  Smack
//
//  Created by Steven on 10/8/18.
//  Copyright © 2018 Steven Santiago. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    //Inspectable to be able to adjust in storyboard
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet{ // function to set variable
            self.layer.cornerRadius = cornerRadius
        }
    }
    override func awakeFromNib() {
        self.setUpView()
    }
    
    //called to update in interface builder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUpView()
    }

    func setUpView(){
        self.layer.cornerRadius = cornerRadius
    }
}
