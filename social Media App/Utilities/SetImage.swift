//
//  SetImage.swift
//  social Media App
//
//  Created by mohamed ahmed on 19/08/2023.
//

import Foundation
import UIKit
extension UIImageView{
    func setImageFromStringUrl(stringUrl: String){
        
        if let url=URL(string: stringUrl){
            let imageData=(try?Data(contentsOf: url))!
            self.image=UIImage(data: imageData)
            
            
        }
        
    }
    
    func makeCirclarImage(){
        self.layer.cornerRadius=self.frame.width/2
    }
    
}
