//
//  AppDelegate.Firebase.swift
//  FirestoreHelpers
//
//  Created by Jay Salvador on 15/7/19.
//  Copyright © 2019 Jay Salvador. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseFirestore

extension AppDelegate {
    
    func setupFirebaseApplication(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        FirebaseApp.configure()
    }
}
