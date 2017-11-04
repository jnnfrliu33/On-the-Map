//
//  TextFieldDelegate.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 04/11/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import UIKit

// MARK: - TextFieldDelegate: NSObject, UITextFieldDelegate

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
