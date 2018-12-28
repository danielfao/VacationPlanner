//
//  ResultsViewController.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 28/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: String(describing: ResultsTableViewCell.self))
            self.tableView.register(UINib(nibName: String(describing: ResultsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ResultsTableViewCell.self))
            self.tableView.separatorStyle = .singleLine
            self.tableView.backgroundColor = UIColor.lightGray1
        }
    }
    
    // MARK: - Variables
    var filteredResults: [[Results]] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar
        self.navigationItem.title = NSLocalizedString("results_title", comment: "")
    }
}

// MARK: - UITableViewDataSource
extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResultsTableViewCell.self), for: indexPath) as? ResultsTableViewCell {
            cell.setupCell(result: filteredResults[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension ResultsViewController: UITableViewDelegate {
    
}
