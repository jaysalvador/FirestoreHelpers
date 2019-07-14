//
//  Notes.swift
//  FirestoreHelpers
//
//  Created by Jay Salvador on 15/7/19.
//  Copyright © 2019 Jay Salvador. All rights reserved.
//

import Foundation

struct Notes: Codable {
    
    var id: String?
    var date: Date?
    var latitude: Double?
    var longitude: Double?
    var notes: String?
    var user: User?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "documentId"
        case date
        case latitude
        case longitude
        case notes
        case user
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.date = try container.decodeIfPresent(Date.self, forKey: .date)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        self.notes = try container.decodeIfPresent(String.self, forKey: .notes)
        self.user = try container.decodeIfPresent(User.self, forKey: .user)
    }
}
