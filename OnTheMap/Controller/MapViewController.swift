//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 23/10/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import UIKit
import MapKit

// MARK: - MapViewController: UIViewController

class MapViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    var annotations = [MKPointAnnotation]()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ParseClient.sharedInstance().getStudentLocations() { (studentLocations, error) in
            if let studentLocations = studentLocations {
                StudentEntries.studentEntriesArray = studentLocations as! [StudentInformation]
                self.addAnnotationsToMapView(StudentEntries.studentEntriesArray)
                
                performUIUpdatesOnMain {
                    self.activityIndicator.stopAnimating()
                }
            } else {
                AlertView.showAlert(controller: self, message: AlertView.Messages.emptyError)
            }
        }
    }
    
    // MARK: Helpers
    
    func removeAnnotations() {
        mapView.removeAnnotations(annotations)
        annotations.removeAll()
    }
    
    func addAnnotationsToMapView(_ studentLocations: [StudentInformation]) {
        
        // Remove annotations from map view if previously loaded
        removeAnnotations()
        
        for studentLocation in StudentEntries.studentEntriesArray {
            let latitude = CLLocationDegrees(studentLocation.latitude!)
            let longitude = CLLocationDegrees(studentLocation.longitude!)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let firstName = studentLocation.firstName!
            let lastName = studentLocation.lastName!
            let mediaURL = studentLocation.mediaURL!
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = firstName + " " + lastName
            annotation.subtitle = mediaURL
            
            self.annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
    }
}

// MARK: - MapViewController: MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    // Create a view with a "right callout accessory view"
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            
            // Make sure URL is valid
            if let url = URL(string: (view.annotation?.subtitle!)!), app.canOpenURL(url) {
                app.open(url, options: [:], completionHandler: nil)
            } else {
                AlertView.showAlert(controller: self, message: AlertView.Messages.invalidURL)
            }
        }
    }
}
