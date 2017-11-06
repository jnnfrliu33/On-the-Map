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
        
        // Make a new server call
        ParseClient.sharedInstance().getStudentLocations() { (studentLocations, error) in
            if let studentLocations = studentLocations {
                
                // Refresh the entries in studentEntriesArray
                StudentEntries.studentEntriesArray = studentLocations as! [StudentInformation]
                
                performUIUpdatesOnMain {
                    mapViewController.activityIndicator.isHidden = false
                    mapViewController.activityIndicator.startAnimating()
                    
                    mapViewController.addAnnotationsToMapView(StudentEntries.studentEntriesArray)
                    tableViewController.loadView()
                    
                    mapViewController.activityIndicator.stopAnimating()
                }
            } else {
                AlertView.showAlert(controller: self, message: AlertView.Messages.emptyError)
            }
        }
    }
    
    @IBAction func addLocationPressed(_ sender: Any) {
        
        // Check if user has already posted a student location
        if ParseClient.sharedInstance().objectID != nil {
            let alert = UIAlertController(title: "Overwrite location?", message: AlertView.Messages.locationAlreadyPosted, preferredStyle: .alert)
            
            // Push AddLocationViewController if user clicks yes
            let okAction = UIAlertAction(title: "Yes", style: .default, handler: { action in
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
                self.navigationController?.pushViewController(controller, animated: true)
            })
            
            // Dismiss the alert controller if user clicks cancel
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            performUIUpdatesOnMain {
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
