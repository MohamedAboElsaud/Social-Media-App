//
//  ProfileVC.swift
//  social Media App
//
//  Created by mohamed ahmed on 23/08/2023.
//

import UIKit
import Alamofire
import SwiftyJSON
class ProfileVC: UIViewController {
    var user:User!
    var userid:Int!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userCountryLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userid!)
        UserAPI.getUserInfo(id: userid!) { user in
            self.userImageView.setImageFromStringUrl(stringUrl: user.image!)
            self.userNameLabel.text=user.firstName+" "+user.lastName
            self.userEmailLabel.text=user.email
            self.userPhoneLabel.text=user.phone
            self.userGenderLabel.text=user.gender
            self.userCountryLabel.text=user.address!.address
            self.userImageView.makeCirclarImage()
        }
       
        
        // Do any additional setup after loading the view.
    }
    
}
