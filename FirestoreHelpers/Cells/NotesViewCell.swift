//
//  NotesViewCell.swift
//  FirestoreHelpers
//
//  Created by Jay Salvador on 15/7/19.
//  Copyright © 2019 Jay Salvador. All rights reserved.
//

import UIKit

class NotesViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    func prepare(with note: Notes) -> UITableViewCell {
        
        return self.prepare(
            with: UIImage.init(named: note.user?.icon ?? ""),
            username: note.user?.username,
            notes: note.notes)
    }
    
    func prepare(with image: UIImage?, username: String?, notes: String?) -> UITableViewCell {
        
        self.avatar.image = image
        
        self.nameLabel.text = username
        
        self.notesLabel.text = notes
        
        return self
    }
}
