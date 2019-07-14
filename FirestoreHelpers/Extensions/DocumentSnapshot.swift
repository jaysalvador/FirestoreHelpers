//
//  QueryDocumentSnapshot.swift
//  PlaySport
//
//  Created by Jay Andrae on 28/2/19.
//  Copyright © 2019 PlaySport Holdings Pty Ltd. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

extension DocumentSnapshot {
    
    func document() -> [String: Any]? {
        
        var data = self.data()
        
        data?["documentId"] = self.documentID
        
        return data?.filter { ($1 as? GeoPoint) == nil }
    }
}
