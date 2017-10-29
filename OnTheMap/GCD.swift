//
//  GCD.swift
//  OnTheMap
//
//  Created by Jennifer Liu on 26/10/2017.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
