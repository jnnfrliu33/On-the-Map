//
//  StudentInformationStruct.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 06/11/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import Foundation

struct StudentInformation {
    
    // MARK: Properties
    
    var firstName: String?
    var lastName: String?
    var latitude: Double?
    var longitude: Double?
    var mediaURL: String?
    
    // MARK: Initializers
    
    // Construct a StudentInformation from a dictionary
    init(dictionary: [String:AnyObject]) {
        
        if let firstNameString = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String, firstNameString.isEmpty == false {
            firstName = firstNameString
        } else {
            firstName = ""
        }
        
        if let lastNameString = dictionary[ParseClient.JSONResponseKeys.LastName] as? String, lastNameString.isEmpty == false {
            lastName = lastNameString
        } else {
            lastName = ""
        }
        
        if let latitudeDouble = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Double, latitudeDouble.isNaN == false {
            latitude = latitudeDouble
        } else {
            latitude = 0.0
        }
        
        if let longitudeDouble = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Double, longitudeDouble.isNaN == false {
            longitude = longitudeDouble
        } else {
            longitude = 0.0
        }
        
        if let mediaURLString = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String, mediaURLString.isEmpty == false {
            mediaURL = mediaURLString
        } else {
            mediaURL = ""
        }
    }
}
