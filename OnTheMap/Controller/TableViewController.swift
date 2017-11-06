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
    
    // MARK: Outlets
    
    @IBOutlet var studentLocationsTableView: UITableView!
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ParseClient.sharedInstance().getStudentLocations() { (studentLocations, error) in
            if let studentLocations = studentLocations {
                StudentEntries.studentEntriesArray = studentLocations as! [StudentInformation]
                
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
        return StudentEntries.studentEntriesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationCell")!
        
        // Access student location for a given row
        let studentLocation = StudentEntries.studentEntriesArray[(indexPath as NSIndexPath).row]
        
        // Set the label and image
        cell.imageView!.image = UIImage(named: "PinIcon")
        cell.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        
        cell.textLabel?.text = studentLocation.firstName! + " " + studentLocation.lastName!
        cell.detailTextLabel?.text = studentLocation.mediaURL!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Access student location for a given row
        let studentLocation = StudentEntries.studentEntriesArray[(indexPath as NSIndexPath).row]
        
        // Open the URL in Safari in the given row
        let app = UIApplication.shared
        
        // Make sure URL is valid
        if let url = URL(string: (studentLocation.mediaURL)!), app.canOpenURL(url) {
            app.open(url, options: [:], completionHandler: nil)
        } else {
            AlertView.showAlert(controller: self, message: AlertView.Messages.invalidURL)
        }
    }
}
