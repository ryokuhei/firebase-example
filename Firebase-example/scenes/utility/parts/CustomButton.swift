//
//  LoginButton.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/02/02.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomButton: UIButton {
    
    // cornar
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    // border
    @IBInspectable var borderColor: UIColor = UIColor.MyTheme.buttonBorder
    @IBInspectable var borderWith: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = (cornerRadius > 0)
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWith
        
        super.draw(rect)
        
        
    }
}
