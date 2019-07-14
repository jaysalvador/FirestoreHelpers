//
//  FirebaseClient.swift
//  PlaySport
//
//  Created by Jay Andrae on 28/2/19.
//  Copyright © 2019 PlaySport Holdings Pty Ltd. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

typealias FirebaseCompletionClosure<T> = ((FirestoreResult<T>) -> Void)

enum FirestoreClientListenerKey: String {
    
    case defaultListener
}

protocol FirestoreClientProtocol {
    
    var listeners: Dictionary<String, ListenerRegistration?>? { get }

    var firestore: Firestore? { get }
    
    func get<T>(_ type: T.Type, document: DocumentReference?, onCompletion: FirebaseCompletionClosure<T>?) where T: Decodable

    func query<T>(_ type: T.Type, query: Query?, onCompletion: FirebaseCompletionClosure<T>?) where T: Decodable
    
    func listen<T>(_ type: T.Type, query: Query?, onCompletion: FirebaseCompletionClosure<T>?) -> ListenerRegistration? where T: Decodable
    
    func listen<T>(_ type: T.Type, query: Query?, includeMetadataChanges: Bool, onCompletion: FirebaseCompletionClosure<T>?) -> ListenerRegistration? where T: Decodable
    
    func removeListener(_ key: FirestoreClientListenerKey)
    
    func removeListeners()
}

class FirestoreClient: FirestoreClientProtocol {
    
    // MARK: - ChatGroupFirebaseClient - Data
    
    private(set) var listeners: Dictionary<String, ListenerRegistration?>?
    
    private(set) var firestore: Firestore?
    
    convenience init?() {
        
        self.init(firestore: Firestore.firestore())
    }
    
    init(firestore _firestore: Firestore?) {
        
        self.firestore = _firestore
        
        self.listeners = Dictionary<String, ListenerRegistration?>()
    }
    
    func get<T>(_ type: T.Type, document: DocumentReference?, onCompletion: FirebaseCompletionClosure<T>?) where T: Decodable {
        
        guard let document = document else {
            
            onCompletion?(.failed(.encoding))
            
            return
        }
        
        document.getDocument { (snapshot, error) in
            
            self.decode(type, snapshot: snapshot, error: error, onCompletion: onCompletion)
        }
    }
    
    func query<T>(_ type: T.Type, query: Query?, onCompletion: FirebaseCompletionClosure<T>?) where T: Decodable {
        
        guard let query = query else {
            
            onCompletion?(.failed(.encoding))
            
            return
        }
        
        query.getDocuments { [weak self] (snapshot, error) in
            
            self?.decode(type, snapshot: snapshot, error: error, onCompletion: onCompletion)
        }
    }
    
    func listen<T>(_ type: T.Type, query: Query?, onCompletion: FirebaseCompletionClosure<T>?) -> ListenerRegistration? where T: Decodable {
        
        return self.listen(type, query: query, includeMetadataChanges: false, onCompletion: onCompletion)
    }
    
    func listen<T>(_ type: T.Type, query: Query?, includeMetadataChanges: Bool = false, onCompletion: FirebaseCompletionClosure<T>?) -> ListenerRegistration? where T: Decodable {
        
        guard let query = query else {
            
            onCompletion?(.failed(.encoding))
            
            return nil
        }
        
        return query.addSnapshotListener(
            includeMetadataChanges: includeMetadataChanges,
            listener: { [weak self] (snapshot, error) in self?.decode(type, snapshot: snapshot, error: error, onCompletion: onCompletion) }
        )
    }
    
    private func decode<T>(_ type: T.Type, snapshot: QuerySnapshot?, error: Error?, onCompletion: FirebaseCompletionClosure<T>?) where T: Decodable {
        
        guard let snapshot = snapshot, error == nil else {
                
            onCompletion?(.failed(.unknown(error)))
            
            return
        }
        
        let documents = snapshot.documents.compactMap { $0.document() }
        
        self.decode(type, document: documents, onCompletion: onCompletion)
    }
    
    private func decode<T>(_ type: T.Type, snapshot: DocumentSnapshot?, error: Error?, onCompletion: FirebaseCompletionClosure<T>?) where T: Decodable {
        
        guard let snapshot = snapshot, error == nil, let document = snapshot.document() else {
            
            onCompletion?(.failed(.unknown(error)))
            
            return
        }
        
        self.decode(type, document: document, onCompletion: onCompletion)
    }

    private func decode<T>(_ type: T.Type, document: Any, onCompletion: FirebaseCompletionClosure<T>?) where T: Decodable {
        
        do {
            
            let decoder = JSONDecoder()
            
            decoder.dateDecodingStrategy = .formatted(.fullIso8601)
            
            let decoded = try decoder.decode(type, fromJSONObject: document)
            
            onCompletion?(.successful(decoded))
        }
        catch {
            
            onCompletion?(.failed(.decoding(statusCode: 0)))
        }
    }
    
    func addListener(_ key: FirestoreClientListenerKey, listener: ListenerRegistration?) {
        
        self.removeListener(key)
        
        self.listeners?[key.rawValue] = listener
    }
    
    func removeListener(_ key: FirestoreClientListenerKey) {
        
        if let listeners = self.listeners,
            listeners.containsKey(key.rawValue),
            let listener = listeners[key.rawValue] {
            
            listener?.remove()
        }
    }
    
    func removeListeners() {
        
        self.listeners?.values.forEach { $0?.remove() }
    }
}
