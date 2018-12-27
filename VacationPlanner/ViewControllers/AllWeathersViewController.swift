//
//  AllWeathersViewController.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

class AllWeathersViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: String(describing: WeatherTableViewCell.self))
            self.tableView.register(UINib(nibName: String(describing: WeatherTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WeatherTableViewCell.self))
            self.tableView.separatorStyle = .singleLine
            self.tableView.bounces = false
            self.tableView.backgroundColor = UIColor.lightGray1
            self.tableView.allowsMultipleSelection = true
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Navigation Bar
        self.navigationItem.title = NSLocalizedString("weathers_title", comment: "")
    }
}

// MARK: - Table View Data Source Extension
extension AllWeathersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherTableViewCell.self), for: indexPath) as? WeatherTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - Table View Delegate
extension AllWeathersViewController: UITableViewDelegate {
  
}
