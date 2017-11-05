//
//  AddLocationMapViewController.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 27/10/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import UIKit
import MapKit

// MARK: - AddLocationMapViewController: UIViewController

class AddLocationMapViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: RoundedButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    var placemark: CLPlacemark? = nil
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if placemark != nil {
            
            // Zoom in the map on the location
            let location = placemark?.location
            centerMapOnLocation(location!)
            
            // Set the annotation on the map
            let annotation = MKPointAnnotation()
            annotation.coordinate = (location?.coordinate)!
            annotation.title = placemark?.name!
            
            // Store location name, latitude and longitude to ParseClient
            ParseClient.sharedInstance().mapString = placemark?.name
            ParseClient.sharedInstance().latitude = location?.coordinate.latitude
            ParseClient.sharedInstance().longitude = location?.coordinate.longitude
            
            self.mapView.addAnnotation(annotation)
            self.activityIndicator.stopAnimating()
            
        } else {
            AlertView.showAlert(controller: self, message: AlertView.Messages.emptyPlacemark)
        }
    }
    
    // MARK: Actions
    
    @IBAction func finishButtonPressed(_ sender: Any) {
        
        // Get user's first and last name
        UdacityClient.sharedInstance().getUserData() { (result, error) in
            
            if let error = error {
                AlertView.showAlert(controller: self, message: error.localizedDescription)
            } else {
                if let firstName = result?[UdacityClient.JSONResponseKeys.FirstName] as? String, let lastName = result?[UdacityClient.JSONResponseKeys.LastName] as? String {
                    
                    // Store user's first and last name to UdacityClient
                    UdacityClient.sharedInstance().firstName = firstName
                    UdacityClient.sharedInstance().lastName = lastName

                    // Check if user has already posted a student location
                    if ParseClient.sharedInstance().objectID == nil {
                        
                        // Post new student location
                        ParseClient.sharedInstance().postStudentLocation(accountKey: UdacityClient.sharedInstance().userID!, firstName: firstName, lastName: lastName, mapString: ParseClient.sharedInstance().mapString!, mediaURL: ParseClient.sharedInstance().mediaURL!, latitude: ParseClient.sharedInstance().latitude!, longitude: ParseClient.sharedInstance().longitude!) { (result, error) in
                            
                            if let error = error {
                                AlertView.showAlert(controller: self, message: error.localizedDescription)
                            } else {
                                performUIUpdatesOnMain {
                                    self.navigationController?.popToRootViewController(animated: true)
                                }
                            }
                        }

                    } else {
                        
                        // Update existing student location
                        ParseClient.sharedInstance().updateStudentLocation(accountKey: UdacityClient.sharedInstance().userID!, firstName: firstName, lastName: lastName, mapString: ParseClient.sharedInstance().mapString!, mediaURL: ParseClient.sharedInstance().mediaURL!, latitude: ParseClient.sharedInstance().latitude!, longitude: ParseClient.sharedInstance().longitude!) { (result, error) in
                            
                            if let error = error {
                                AlertView.showAlert(controller: self, message: error.localizedDescription)
                            } else {
                                performUIUpdatesOnMain {
                                    self.navigationController?.popToRootViewController(animated: true)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: Helpers
    
    // Define zoom radius of location
    let regionRadius: CLLocationDistance = 500
    func centerMapOnLocation (_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
}

// MARK: - AddLocationMapViewController: MKMapViewDelegate

extension AddLocationMapViewController: MKMapViewDelegate {
    
    // Create a view with a "right callout accessory view"
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
}
