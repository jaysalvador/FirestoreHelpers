//
//  CGeoPoint.swift
//  FirestoreHelpers
//
//  Created by Jay Salvador on 15/7/19.
//  Copyright © 2019 Jay Salvador. All rights reserved.
//

import FirebaseCore
import FirebaseFirestore

final class CGeoPoint: GeoPoint, Codable {
    
    override init(latitude: Double, longitude: Double) {
        
        super.init(latitude: latitude, longitude: longitude)
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case latitude  = "_latitude"
        case longitude = "_longitude"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var lat: Double = 0
        
        var lon: Double = 0
        
        do {
            
            lat = try container.decode(Double.self, forKey: .latitude)
        }
        catch {
            
            print("no latitude for MyGeoPoint")
        }
        
        do {
            
            lon = try container.decode(Double.self, forKey: .longitude)
        }
        catch {
            
            print("no longitude for MyGeoPoint")
        }
        
        super.init(latitude: lat, longitude: lon)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(latitude,  forKey: .latitude)
        
        try container.encode(longitude, forKey: .longitude)
    }
    
}
