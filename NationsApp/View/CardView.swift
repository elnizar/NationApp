//
//  CardView.swift
//  NationsApp
//
//  Created by Nizar Elhraiech on 27/01/2019.
//  Copyright © 2019 Nizar. All rights reserved.
//

import UIKit

import UIKit

class CardView: UIView {
    
    @IBInspectable var cornerRadius : CGFloat = 2
    @IBInspectable var shadowOffSetWidth : CGFloat = 0
    @IBInspectable var shadowOffSetHight : CGFloat = 0
    @IBInspectable var shadowColor : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    @IBInspectable var shadowOpacity : CGFloat = 0.2
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
    
}
