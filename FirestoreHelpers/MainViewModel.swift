//
//  MainViewModel.swift
//  FirestoreHelpers
//
//  Created by Jay Salvador on 15/7/19.
//  Copyright © 2019 Jay Salvador. All rights reserved.
//

import Foundation

typealias ViewModelCallback = (() -> Void)

protocol MainViewModelProtocol {
    
    var notes: Array<Notes>? { get set }
    
    var onUpdated: ViewModelCallback? { get set }
    
    var onError: ViewModelCallback? { get set }
    
    func setup()
}

class MainViewModel: MainViewModelProtocol {
    
    private var notesClient: NotesClientProtocol?
    
    var notes: Array<Notes>?
    
    var onUpdated: ViewModelCallback?
    
    var onError: ViewModelCallback?
    
    convenience init() {
        
        self.init(notesClient: NotesClient())
    }
    
    init(notesClient _notesClient: NotesClientProtocol?) {
        
        self.notesClient = _notesClient
    }
    
    func setup() {
        
        self.notesClient?.listenToNotes(
            .defaultListener,
            limit: nil,
            onCompletion: { [weak self] (response) in
                
                if case .successful(let result) = response {
                    
                    self?.notes = result
                    
                    self?.onUpdated?()
                }
                else {
                    
                    // error
                    self?.onError?()
                }
            }
        )
    }
    
    deinit {
        
        self.notesClient?.removeListeners()
    }
}
