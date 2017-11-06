//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 24/10/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import Foundation

// MARK: - UdacityClient: NSObject

class UdacityClient: NSObject {
    
    // MARK: Properties
    
    var session = URLSession.shared
    
    // New student information
    var userID : String? = nil
    var firstName: String? = nil
    var lastName: String? = nil
    
    // MARK: GET
    
    func taskForUdacityGETMethod (_ url: String, completionHandlerForUdacityGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        /* Build the URL, Configure the request */
        let request = URLRequest(url: URL(string: url)!)
        
        /* Make the request */
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForUdacityGET(nil, NSError(domain: "taskForUdacityGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError((error?.localizedDescription)!)
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Unable to get your Udacity information.")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            /* Parse data */
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForUdacityGET)
        }
        
        /* Start the request */
        task.resume()
        return task
    }
    
    // MARK: POST
    
    func taskForUdacityPOSTMethod (_ url: String, jsonBody: String, completionHandlerForUdacityPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {

        /* Build the URL, Configure the request */
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        
        /* Make the request */
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForUdacityPOST(nil, NSError(domain: "taskForUdacityPOSTMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError((error?.localizedDescription)!)
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Incorrect email and/or password.")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            /* Parse data */
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForUdacityPOST)
        }
        
        /* Start the request */
        task.resume()
        return task
    }
    
    // MARK: DELETE
    
    func taskForUdacityDELETEMethod (_ url: String, completionHandlerForUdacityDELETE: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        /* Build the URL, Configure the request */
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        /* Make the request */
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForUdacityDELETE(nil, NSError(domain: "taskForUdacityDELETEMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError((error?.localizedDescription)!)
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Unable to log out.")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            /* Parse data */
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForUdacityDELETE)
        }
        
        /* Start the request */
        task.resume()
        return task
    }
    
    // MARK: Helpers
    
    // Convert raw JSON into a usable Foundation object
    func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult, nil)
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}
