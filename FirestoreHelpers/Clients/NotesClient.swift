//
//  NotesClient.swift
//  FirestoreHelpers
//
//  Created by Jay Salvador on 15/7/19.
//  Copyright © 2019 Jay Salvador. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol NotesClientProtocol: FirestoreClientProtocol {
    
    func listenToNotes(_ key: FirestoreClientListenerKey, limit: Int?, onCompletion: FirebaseCompletionClosure<Array<Notes>>?)
    func listenToChatGroups(_ key: FirestoreClientListenerKey, query: Query?, onCompletion: FirebaseCompletionClosure<Array<Notes>>?)
}

class NotesClient: FirestoreClient, NotesClientProtocol {
    
    func listenToNotes(_ key: FirestoreClientListenerKey, limit: Int?, onCompletion: FirebaseCompletionClosure<Array<Notes>>?) {
        
        var query = self.firestore?
            .collection("notes")
            .order(by: "date", descending: true)
        
        if let limit = limit {
            
            query = query?.limit(to: limit)
        }
        
        self.listenToChatGroups(key, query: query, onCompletion: onCompletion)
    }
    
    func listenToChatGroups(_ key: FirestoreClientListenerKey, query: Query?, onCompletion: FirebaseCompletionClosure<Array<Notes>>?) {
        
        self.removeListener(key)
        
        let listener = self.listen(
            Array<Notes>.self,
            query: query,
            onCompletion: onCompletion
        )
        
        self.addListener(key, listener: listener)
    }
    
}
