//
//  JSONDecoder.swift
//  PlaySport
//
//  Created by Jay Andrae on 28/2/19.
//  Copyright © 2019 PlaySport Holdings Pty Ltd. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    func decode<T>(_ type: T.Type, fromJSONObject object: Any) throws -> T where T: Decodable {
        
        return try decode(T.self, from: try JSONSerialization.data(withJSONObject: object, options: []))
    }
}
