//
//  CustomUITextField.swift
//  social Media App
//
//  Created by mohamed ahmed on 03/09/2023.
//

import UIKit

class CustomUITextField: UITextField {

    override func awakeFromNib() {
        layer.cornerRadius=10
        layer.borderWidth=2
        layer.borderColor=UIColor.black.cgColor
        clipsToBounds=true
        
    }
    override func layoutSubviews() {
        layer.cornerRadius=10
        layer.borderWidth=2
        layer.borderColor=UIColor.black.cgColor
        clipsToBounds=true
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
}
