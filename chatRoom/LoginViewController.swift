//
//  LoginViewController.swift
//  chatRoom
//
//  Created by Marilyn Florek on 9/28/18.
//  Copyright © 2018 Marilyn Florek. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginAlertMsg: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginAlertMsg.text=""

        // Do any additional setup after loading the view.
    }
    @IBAction func onSignUp(_ sender: Any) {
        
        if (usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)!
        {
            loginAlertMsg.text = "Username or password empty"
        }
        else
        {
            loginAlertMsg.text = ""
            let newUser = PFUser()
            
            newUser.username = usernameField.text
            newUser.password = passwordField.text
            
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if success
                {
                    print("New User!")
                }
                else
                {
                    print(error?.localizedDescription as Any)
                }
            }
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        if (usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)!
        {
            loginAlertMsg.text = "Username or password empty"
        }
        else
        {
            loginAlertMsg.text = ""
            PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user:PFUser?, error:Error?) in
                if user != nil
                {
                    print("You're logged in")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
