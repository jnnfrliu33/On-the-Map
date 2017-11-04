//
//  AlertView.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 04/11/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import Foundation
import UIKit

// MARK: AlertView

class AlertView {
    
    class func showAlert(controller: UIViewController, message: String) {
        let alert = UIAlertController(title: "Something's wrong!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        performUIUpdatesOnMain {
            controller.present(alert, animated: true, completion: nil)
        }
    }
}

extension AlertView {
    
    struct Messages {
        static let usernameOrPasswordFieldEmpty = "Please enter your email and password."
        static let emptyError = "Unable to get student data."
        static let locationFieldEmpty = "Please enter your location."
        static let websiteFieldEmpty = "Please enter a website url."
        static let emptyPlacemark = "Placemark not found."
        static let logoutFailed = "Unable to log out."
    }
}
