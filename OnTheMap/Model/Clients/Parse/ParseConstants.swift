//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 24/10/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import Foundation

// MARK: - ParseClient (Constants)

extension ParseClient {
    
    // MARK: Constants
    struct Constants {
        
        // URL
        static let StudentLocationURL = "https://parse.udacity.com/parse/classes/StudentLocation/"
        
        // HTTP Header Field Values
        static let ParseApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let RESTAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
    
    // MARK: Query Items
    struct QueryItems {
        static let Limit = "limit=100"
        static let SortedByDate = "order=-updatedAt"
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        
        // Account
        static let ObjectID = "objectId"
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        
        // Website URL
        static let MediaURL = "mediaURL"
        
        // Location
        static let MapString = "mapString"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // General
        static let StudentLocationsDictionary = "results"
        
        // Account
        static let ObjectID = "objectId"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        
        // Location
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        
        // Website URL
        static let MediaURL = "mediaURL"
        
        // Session
        static let CreatedAt = "createdAt"
        static let UpdatedAt = "updatedAt"
    }
}
