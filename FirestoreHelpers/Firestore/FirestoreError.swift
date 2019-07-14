//
//  FirebaseError.swift
//  PlaySport
//
//  Created by Jay Andrae on 28/2/19.
//  Copyright © 2019 PlaySport Holdings Pty Ltd. All rights reserved.
//

import Foundation

enum FirestoreError {
    
    case encoding
    case decoding(statusCode: Int)
    case unknown(Error?)
    case nilRequest
}
