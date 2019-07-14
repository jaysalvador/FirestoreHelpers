//
//  Dictionary.swift
//  PlaySport
//
//  Created by Chris Simpson on 8/4/19.
//  Copyright © 2019 PlaySport Holdings Pty Ltd. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    
    func containsKey(_ key: String?) -> Bool {
        
        guard let key = key else {
            
            return false
        }
        
        return self.keys.contains(key)
    }
}
