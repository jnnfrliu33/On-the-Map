//
//  LoginViewController.swiftLoginViewController
//  OnTheMap
//
//  Created by Jennifer Liu on 23/10/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import UIKit

// MARK: - LoginViewController: UIViewController

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: RoundedButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var facebookLoginButton: RoundedButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    let textFieldDelegate = TextFieldDelegate()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.isHidden = true
        
        usernameTextField.delegate = textFieldDelegate
        passwordTextField.delegate = textFieldDelegate
    }
    
    // MARK: Actions
    
    @IBAction func loginPressed(_ sender: Any) {
        
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            AlertView.showAlert(controller: self, message: AlertView.Messages.usernameOrPasswordFieldEmpty)
        } else {
            
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
            UdacityClient.sharedInstance().postSession(username: usernameTextField.text!, password: passwordTextField.text!) { (result, error) in
                
                if let error = error {
                    AlertView.showAlert(controller: self, message: error.localizedDescription)
                    
                } else {
                    if let userID = result?[UdacityClient.JSONResponseKeys.AccountKey] as? String {
                        
                        // Store user ID to Udacity Client
                        UdacityClient.sharedInstance().userID = userID
                        
                        performUIUpdatesOnMain {
                            self.activityIndicator.stopAnimating()
                            self.completeLogin()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        let app = UIApplication.shared
        app.open(URL(string: UdacityClient.Constants.SignUpURL)!, options: [:], completionHandler: nil)
    }
    
    // MARK: Login
    
    private func completeLogin() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "MapNavigationController") as! UINavigationController
        present(controller, animated: true, completion: nil)
    }
}
