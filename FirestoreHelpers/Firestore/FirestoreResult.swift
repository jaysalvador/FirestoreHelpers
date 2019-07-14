//
//  FirebaseResult.swift
//  PlaySport
//
//  Created by Jay Andrae on 28/2/19.
//  Copyright © 2019 PlaySport Holdings Pty Ltd. All rights reserved.
//

import Foundation

enum FirestoreResult<T> {
    
    case successful(T)
    case failed(FirestoreError)
}
