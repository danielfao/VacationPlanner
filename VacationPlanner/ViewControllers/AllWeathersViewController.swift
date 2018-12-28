//
//  AllWeathersViewController.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

protocol AllWeathersViewControllerDelegate: class {
    func didSelectWeathers(selectedWeather: [Weather])
}

class AllWeathersViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: String(describing: WeatherTableViewCell.self))
            self.tableView.register(UINib(nibName: String(describing: WeatherTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WeatherTableViewCell.self))
            self.tableView.separatorStyle = .singleLine
            self.tableView.backgroundColor = UIColor.lightGray1
            self.tableView.allowsMultipleSelection = true
        }
    }
    
    // MARK: - Variables
    private var weathers: [Weather] = [] {
        didSet {
            self.tableView.reloadData()
            
            for previousWeather in self.previouslySelectedWeathers {
                if let row = self.weathers.firstIndex(where: { (weather) -> Bool in
                    return previousWeather.id == weather.id
                }) {
                    self.tableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
                }
            }
            self.previouslySelectedWeathers.removeAll()
        }
    }
    weak var delegate: AllWeathersViewControllerDelegate?
    var previouslySelectedWeathers: [Weather] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Navigation Bar
        self.navigationItem.title = NSLocalizedString("weathers_title", comment: "")
        
        WeatherService.getWeather { (weathers) in
            self.weathers = weathers
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        var selectedWeathers: [Weather] = []
        if let indexPathsForSelectedRows = self.tableView.indexPathsForSelectedRows {
            for indexPath in indexPathsForSelectedRows {
                selectedWeathers.append(self.weathers[indexPath.row])
            }
        }
        self.delegate?.didSelectWeathers(selectedWeather: selectedWeathers)
    }
}

// MARK: - Table View Data Source Extension
extension AllWeathersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherTableViewCell.self), for: indexPath) as? WeatherTableViewCell {
            cell.setupCell(weather: self.weathers[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - Table View Delegate
extension AllWeathersViewController: UITableViewDelegate {
  
}
