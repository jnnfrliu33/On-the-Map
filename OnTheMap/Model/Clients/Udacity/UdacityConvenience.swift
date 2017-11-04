//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 26/10/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import Foundation

// MARK: - UdacityClient (Convenience Resource Methods)

extension UdacityClient {
    
    // MARK: GET Convenience Method
    
    func getUserData (_ completionHandlerForUserData: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) {
        let url = Constants.UserDataURL + userID!
        
        /* Make the request */
        let _ = taskForUdacityGETMethod(url) { (result, error) in
            
            if let error = error {
                completionHandlerForUserData(nil, error)
            } else {
                if let result = result?[JSONResponseKeys.UserInfoDictionary] as? [String:AnyObject] {
                    completionHandlerForUserData(result as AnyObject, nil)
                } else {
                    completionHandlerForUserData(nil, NSError(domain: "getUserData parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getUserData"]))
                }
            }
        }
    }
    
    // MARK: POST Convenience Method
    
    func postSession (username: String, password: String, completionHandlerForSession: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        let url = Constants.AuthorizationURL
        let jsonBody = "{\"\(JSONBodyKeys.Udacity)\": {\"\(JSONBodyKeys.Username)\": \"\(username)\", \"\(JSONBodyKeys.Password)\": \"\(password)\"}}"
        
        /* Make the request */
        let _ = taskForUdacityPOSTMethod(url, jsonBody: jsonBody) { (result, error) in
            
            if let error = error {
                completionHandlerForSession(nil, error)
            } else {
                if let result = result?[JSONResponseKeys.Account] as? [String:AnyObject] {
                    completionHandlerForSession(result as AnyObject, nil)
                } else {
                    completionHandlerForSession(nil, NSError(domain: "postSession parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postSession"]))
                }
            }
        }
    }
    
    // MARK: DELETE Convenience Method
    
    func deleteSession (_ completionHandlerForSession: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        let url = Constants.AuthorizationURL
        
        /* Make the request */
        let _ = taskForUdacityDELETEMethod(url) { (result, error) in
            
            if let error = error {
                completionHandlerForSession(nil, error)
            } else {
                if let result = result?[JSONResponseKeys.Session] as? [String:AnyObject] {
                    completionHandlerForSession(result as AnyObject, nil)
                } else {
                    completionHandlerForSession(nil, NSError(domain: "deleteSession parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse deleteSession"]))
                }
            }
        }
    }
}
