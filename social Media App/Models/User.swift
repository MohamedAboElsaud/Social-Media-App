//
//  User.swift
//  social Media App
//
//  Created by mohamed ahmed on 13/08/2023.
//

import Foundation
struct User:Decodable{
    var id:Int?
    var firstName:String
    var lastName:String
    var image:String?
    var username:String?
    var email:String
    var phone:String?
    var gender:String?
    var address:address?
}
