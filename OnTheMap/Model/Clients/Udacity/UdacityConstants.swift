//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 24/10/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

// MARK: - UdacityClient (Constants)

extension UdacityClient {
    
    // MARK: Constants
    struct Constants {
        
        // URLs
        static let AuthorizationURL = "https://www.udacity.com/api/session"
        static let UserDataURL = "https://www.udacity.com/api/users/"
        static let AccountURL = "https://www.udacity.com/account/auth#!/signup"
    }
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        
        // User Information
        static let UserInfoDictionary = "user"
        static let FirstName = "first_name"
        static let LastName = "last_name"
        static let FacebookID = "_facebook_id"
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // Account
        static let Account = "account"
        static let IsRegistered = "registered"
        static let AccountKey = "key"
        
        // Session
        static let Session = "session"
        static let SessionID = "id"
        static let Expiration = "expiration"
    }
}
