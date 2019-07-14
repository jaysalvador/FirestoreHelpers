//
//  DateFormatter.swift
//  FirestoreHelpers
//
//  Created by Jay Salvador on 15/7/19.
//  Copyright © 2019 Jay Salvador. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let fullIso8601: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return dateFormatter
    }()
}
