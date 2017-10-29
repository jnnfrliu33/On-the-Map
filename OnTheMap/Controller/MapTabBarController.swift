//
//  MapTabBarController.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 26/10/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import UIKit

// MARK: - MapTabBarController: UITabBarController

class MapTabBarController: UITabBarController {
    
    // MARK: Outlets

    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var addLocationButton: UIBarButtonItem!
    
    // MARK: Actions
    
    @IBAction func logoutPressed(_ sender: Any) {
        
        UdacityClient.sharedInstance().deleteSession() { (result, error) in
            
            if let error = error {
                print (error)
            } else {
                if let sessionID = result?[UdacityClient.JSONResponseKeys.SessionID] as? String, sessionID.isEmpty == false {

                    performUIUpdatesOnMain {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
    }
}
