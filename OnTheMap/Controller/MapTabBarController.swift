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
    
    // MARK: Actions
    
    @IBAction func logoutPressed(_ sender: Any) {
        
        UdacityClient.sharedInstance().deleteSession() { (result, error) in
            
            if error != nil {
                AlertView.showAlert(controller: self, message: AlertView.Messages.logoutFailed)
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
        
        let mapViewController = self.viewControllers?[0] as! MapViewController
        let tableViewController = self.viewControllers?[1] as! TableViewController
        
        // Remove previous annotations from mapViewController
        mapViewController.mapView.removeAnnotations(mapViewController.annotations)
        
        // Reload the view controllers
        mapViewController.loadView()
        tableViewController.loadView()
    }
}
