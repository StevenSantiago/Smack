//
//  CircleImage.swift
//  Smack
//
//  Created by Steven on 10/21/18.
//  Copyright © 2018 Steven Santiago. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = self.frame.width  / 2
        self.clipsToBounds = true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
}
