//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 23/10/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import UIKit
import CoreLocation

// MARK: - AddLocationViewController: UIViewController

class AddLocationViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    
    // MARK: Properties
    
    lazy var geocoder = CLGeocoder()
    let textFieldDelegate = TextFieldDelegate()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        locationTextField.delegate = textFieldDelegate
        websiteTextField.delegate = textFieldDelegate
    }
    
    // MARK: Actions
    
    @IBAction func websiteTextFieldClicked(_ sender: Any) {
        if websiteTextField.text == "" {
            websiteTextField.text = "https://"
        }
    }
    
    @IBAction func findLocationPressed(_ sender: Any) {
        if locationTextField.text?.isEmpty == false {
            
            geocoder.geocodeAddressString(locationTextField.text!) { (placemarks, error) in
                
                if let error = error {
                    print (error)
                } else {
                    if let placemark = placemarks?.first {
                        
                        let controller = self.storyboard!.instantiateViewController(withIdentifier: "AddLocationMapViewController") as! AddLocationMapViewController
                        
                        // Save the placemark information in the AddLocationMapViewController to be used
                        controller.placemark = placemark
                        
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                }
            }
        }
        
        if websiteTextField.text?.isEmpty == false {
            
            // Save the website url for POST request
            ParseClient.sharedInstance().mediaURL = websiteTextField.text
        }
    }
}
