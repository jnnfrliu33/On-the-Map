//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 23/10/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import UIKit

// MARK: - TableViewController: UITableViewController

class TableViewController: UITableViewController {
    
    // MARK: Properties
    
    var studentLocations = [StudentInformation]()
    
    // MARK: Outlets
    
    @IBOutlet var studentLocationsTableView: UITableView!
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ParseClient.sharedInstance().getStudentLocations() { (studentLocations, error) in
            if let studentLocations = studentLocations {
                self.studentLocations = studentLocations as! [StudentInformation]
                performUIUpdatesOnMain {
                    self.studentLocationsTableView.reloadData()
                }
            } else {
                AlertView.showAlert(controller: self, message: AlertView.Messages.emptyError)
            }
        }
    }
}

// MARK: - TableViewController (Table View Data Source)

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationCell")!
        
        // Access student location for a given row
        let studentLocation = studentLocations[(indexPath as NSIndexPath).row]
        
        // Set the label and image
        cell.imageView!.image = UIImage(named: "PinIcon")
        cell.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        
        cell.textLabel?.text = studentLocation.firstName! + " " + studentLocation.lastName!
        cell.detailTextLabel?.text = studentLocation.mediaURL!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Access student location for a given row
        let studentLocation = studentLocations[(indexPath as NSIndexPath).row]
        
        // Open the URL in Safari for the given row
        let app = UIApplication.shared
        if let toOpen = studentLocation.mediaURL {
            app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
        }
    }
}
