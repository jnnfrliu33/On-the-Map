//
//  StudentEntries.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 06/11/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import Foundation

// MARK: - StudentEntries

class StudentEntries {
    
    // MARK: Properties
    
    static var studentEntriesArray = [StudentInformation]()
    
    // MARK: Functions
    
    static func studentArrayFromResults(_ results: [[String:AnyObject]]) -> [StudentInformation] {
        
        var studentArray = [StudentInformation]()
        
        for result in results {
            studentArray.append(StudentInformation(dictionary: result))
        }
        
        return studentArray
    }
}
