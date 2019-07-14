//
//  MainViewController.swift
//  FirestoreHelpers
//
//  Created by Jay Salvador on 15/7/19.
//  Copyright © 2019 Jay Salvador. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - View model
    
    private var viewModel: MainViewModelProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
    }
    
    convenience init() {
        
        self.init(viewModel: MainViewModel())
    }
    
    init(viewModel _viewModel: MainViewModelProtocol?) {
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = _viewModel
        
        self.setupViewModel()
    }
    
    private func setupViewModel() {
        
        self.viewModel?.onError = {
            
        }
        self.viewModel?.onUpdated = { [weak self] in
                        
            self?.tableView.reloadData()
        }
    }
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.viewModel?.setup()
        
        self.tableView.register(cell: NotesViewCell.self)
    }
    
    //MARK: - tableview
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel?.notes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusable(cell: NotesViewCell.self),
            let note = self.viewModel?.notes?[indexPath.row] {
            
            return cell.prepare(with: note)
        }
        
        return UITableViewCell()
    }


}
