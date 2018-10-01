//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Danny on 9/30/18.
//  Copyright © 2018 Danny Rivera. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    static let invalidEntryTitle = "Username and password required"
    static let invalidEntryMessage = "Please enter your username and password"
    static let invalidNetworkRegistrationTitle = "We are experimenting a network issue";
    static let invalidNetworkRegistrationMessage = "Sorry about the inconvenice. Please come back at a later time"
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUpClicked(_ sender: UIButton) {
        if (!(usernameTextField.text?.isEmpty)! &&
            !(passwordTextField.text?.isEmpty)!) {
            registerUser()
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        } else {
            showAlertDialogMessage(title: LoginViewController.invalidEntryTitle, message: LoginViewController.invalidEntryMessage)
        }
    }
    
    @IBAction func onLoginClicked(_ sender: UIButton) {
        if (!(usernameTextField.text?.isEmpty)! &&
            !(passwordTextField.text?.isEmpty)!) {
            loginUser()
        } else {
            showAlertDialogMessage(title: LoginViewController.invalidEntryTitle, message: LoginViewController.invalidEntryMessage)
        }
    }
    
    func showAlertDialogMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    func registerUser() {
        let newUser = PFUser()
        newUser.username = usernameTextField.text
        newUser.password = usernameTextField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                self.showAlertDialogMessage(title: LoginViewController.invalidNetworkRegistrationTitle, message: LoginViewController.invalidNetworkRegistrationMessage)
                
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
    }
    
    func loginUser() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                self.showAlertDialogMessage(title: LoginViewController.invalidNetworkRegistrationTitle, message: LoginViewController.invalidNetworkRegistrationMessage)
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
