//
//  UITableView.swift
//  FirestoreHelpers
//
//  Created by Jay Salvador on 15/7/19.
//  Copyright © 2019 Jay Salvador. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(cell: UITableViewCell.Type, forCellReuseIdentifier cellIdentifier: String? = nil) {
        
        let name = String(describing: cell)
        
        self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: cellIdentifier ?? name)
    }
    
    func dequeueReusable<T: UITableViewCell>(cell: T.Type) -> T? {
        
        let name = String(describing: cell)
        
        return self.dequeueReusableCell(withIdentifier: name) as? T
    }
}
