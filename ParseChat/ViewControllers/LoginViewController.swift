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
    
    @IBAction func onSignUpClicked(_ sender: Any) {
        let user = PFUser()
        user.username = usernameTextField.text ?? ""
        user.password = passwordTextField.text ?? ""
        
        user.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                self.showAlertDialogMessage(title: LoginViewController.invalidNetworkRegistrationTitle, message: LoginViewController.invalidNetworkRegistrationMessage)
            } else {
                print("User Registered successfully")
                print("Username: \(user.username!) \n")
                print("Authentication value: \(user.isAuthenticated) \n")
                print("User Token: \(user.sessionToken!) \n")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    @IBAction func onLoginClicked(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if ((usernameTextField.text?.isEmpty)! &&
            (passwordTextField.text?.isEmpty)!) {
            showAlertDialogMessage(title: LoginViewController.invalidEntryTitle, message: LoginViewController.invalidEntryMessage)
        } else {
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if user != nil {
                    // TODO: go to home screen
                    NSLog("Successfully logged in.")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                } else {
                    self.showAlertDialogMessage(title: LoginViewController.invalidNetworkRegistrationTitle, message: LoginViewController.invalidNetworkRegistrationMessage)
                }
            }
        }
    }
    
    /*
    *   Shows Alert Dialog Message when user does not signup or sign in correctly
    *   @param title - The title from the Alert Dialog
    *   @param message - The message from the Alert Dialog
    */
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
