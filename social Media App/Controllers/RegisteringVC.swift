//
//  RegisteringVC.swift
//  social Media App
//
//  Created by mohamed ahmed on 25/08/2023.
//

import UIKit
import Alamofire
import SwiftyJSON
class RegisteringVC: UIViewController {

    @IBOutlet weak var userEmailInput: UITextField!
    @IBOutlet weak var userLastNameInput: UITextField!
    @IBOutlet weak var userFirstNameInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    @IBAction func registerButton(_ sender: Any) {

        UserAPI.createUser(firstName: userFirstNameInput.text!, lastName: userLastNameInput.text!, email: userEmailInput.text!) { user, error in
            if user != nil{
                let alert=UIAlertController(title: "succes", message: "created new user named: "+self.userFirstNameInput.text!, preferredStyle: .alert)
                let action=UIAlertAction(title: "Ok", style: .default,handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true)
            }else{
                let alert=UIAlertController(title: "fail", message: error!, preferredStyle: .alert)
                let action=UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)

            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
