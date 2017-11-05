//
//  ParseConvenience.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 27/10/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import Foundation

// MARK: - ParseClient (Convenience Resource Methods)

extension ParseClient {
    
    // MARK: GET Convenience Methods
    
    func getStudentLocations (_ completionHandlerForStudentLocations: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        let url = Constants.StudentLocationURL + "?" + QueryItems.Limit + "&" + QueryItems.SortedByDate
        
        /* Make the request */
        let _ = taskForParseGETMethod(url) { (results, error) in
            
            if let error = error {
                completionHandlerForStudentLocations(nil, error)
            } else {
                if let results = results?[JSONResponseKeys.StudentLocationsDictionary] as? [[String:AnyObject]] {
                    let studentLocations = StudentInformation.studentArrayFromResults(results)
                    completionHandlerForStudentLocations(studentLocations as AnyObject, nil)
                } else {
                    completionHandlerForStudentLocations(nil, NSError(domain: "getStudentLocations parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocations"]))
                }
            }
        }
    }
    
    // MARK: POST Convenience Methods
    
    func postStudentLocation (accountKey: String, firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: Double, longitude: Double, completionHandlerForStudentLocations: @escaping (_ result: String?, _ error: NSError?) -> Void) {
        
        let url = Constants.StudentLocationURL
        let jsonBody = "{\"\(JSONBodyKeys.UniqueKey)\": \"\(accountKey)\", \"\(JSONBodyKeys.FirstName)\": \"\(firstName)\", \"\(JSONBodyKeys.LastName)\": \"\(lastName)\",\"\(JSONBodyKeys.MapString)\": \"\(mapString)\", \"\(JSONBodyKeys.MediaURL)\": \"\(mediaURL)\",\"\(JSONBodyKeys.Latitude)\": \(String(latitude)), \"\(JSONBodyKeys.Longitude)\": \(String(longitude))}"
        
        /* Make the request */
        let _ = taskForParsePOSTMethod(url, jsonBody: jsonBody) { (result, error) in
            
            if let error = error {
                completionHandlerForStudentLocations(nil, error)
            } else {
                if let result = result?[JSONResponseKeys.ObjectID] as? String {
                    
                    // Store object ID
                    self.objectID = result
                    
                    completionHandlerForStudentLocations(result, nil)
                } else {
                    completionHandlerForStudentLocations(nil, NSError(domain: "postStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postStudentLocation"]))
                }
            }
        }
    }
    
    // MARK: PUT Convenience Methods
    
    func updateStudentLocation (accountKey: String, firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: Double, longitude: Double, completionHandlerForStudentLocation: @escaping (_ result: String?, _ error: NSError?) -> Void) {
        
        let url = Constants.StudentLocationURL + self.objectID!
        let jsonBody = "{\"\(JSONBodyKeys.UniqueKey)\": \"\(accountKey)\", \"\(JSONBodyKeys.FirstName)\": \"\(firstName)\", \"\(JSONBodyKeys.LastName)\": \"\(lastName)\",\"\(JSONBodyKeys.MapString)\": \"\(mapString)\", \"\(JSONBodyKeys.MediaURL)\": \"\(mediaURL)\",\"\(JSONBodyKeys.Latitude)\": \(String(latitude)), \"\(JSONBodyKeys.Longitude)\": \(String(longitude))}"
        
        /* Make the request */
        let _ = taskForParsePUTMethod(url, jsonBody: jsonBody) { (result, error) in
            
            if let error = error {
                completionHandlerForStudentLocation(nil, error)
            } else {
                if let result = result?[JSONResponseKeys.UpdatedAt] as? String, result != "" {
                    completionHandlerForStudentLocation(result, nil)
                } else {
                    completionHandlerForStudentLocation(nil, NSError(domain: "updateStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse updateStudentLocation"]))
                }
            }
        }
    }
}
