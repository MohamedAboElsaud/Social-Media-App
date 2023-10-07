//
//  Post.swift
//  social Media App
//
//  Created by mohamed ahmed on 13/08/2023.
//

import Foundation
import UIKit
struct Post :Decodable{
    var reactions:Int
    var id:Int
    var userId:Int
    var title:String
    var body:String
    var tags:[String]
    
}
