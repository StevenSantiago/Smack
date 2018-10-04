//
//  GradientView.swift
//  Smack
//
//  Created by Steven on 10/3/18.
//  Copyright © 2018 Steven Santiago. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1){ // Allow to have a color picker on the inspector for Storyboard
        didSet{
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1){ // Allow to have a color picker on the inspector for Storyboard
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        //Creating Layer as well as color position and inserting into view
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Point start at 0,0 and End 1,1, can be anything in between. Gradient goes from point to point and are perpendicular to this.
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
