//
//  LoginVC.swift
//  social Media App
//
//  Created by mohamed ahmed on 27/08/2023.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var firstNameLoginInput: UITextField!
    @IBOutlet weak var lastNameLoginInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameLoginInput.text="Terry"
        lastNameLoginInput.text="Medhurst"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func createAccountButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func skipButton(_ sender: Any) {
        let st = self.storyboard?.instantiateViewController(identifier: "MainTabBar")
        self.present(st!, animated: true)

    }
    
    @IBAction func loginButton(_ sender: Any) {
        UserAPI.getUser(firstName: firstNameLoginInput.text!, lastName: lastNameLoginInput.text!) { user, error in
            if user != nil{
                
                let alert=UIAlertController(title: "Login succes", message: "Welcom to your home :)", preferredStyle: .alert)
                let action=UIAlertAction(title: "Ok", style: .default){x in
                    let st = self.storyboard?.instantiateViewController(identifier: "MainTabBar")
                    self.firstNameLoginInput.text!=""
                    self.lastNameLoginInput.text!=""
                    print(user)
                    UserManager.userInLogged=user
                    self.present(st!, animated: true)
                }
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
