//
//  CustomTextField.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/02/03.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomTextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0

    @IBInspectable var borderColor: UIColor = UIColor.MyTheme.textBorder
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    @IBInspectable var acccessoryBar: Bool = true
    
    override func draw(_ rect: CGRect) {
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftViewMode = .always


        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = (cornerRadius > 0)
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        
        if acccessoryBar {
            addAccessoryBar()
        }

        super.draw(rect)
    }
    
    // accessoryBarにdoneボタンでキーボードを閉じるように実装
    private func addAccessoryBar() {
        let accessoryBar = UIToolbar()
        accessoryBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(doneButtonTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryBar.setItems([spacer, doneButton], animated: true)
        
        self.inputAccessoryView = accessoryBar
    }
    // doneボタンを押下でキーボードを閉じる
    @objc private func doneButtonTapped() {
        self.resignFirstResponder()
    }
}

