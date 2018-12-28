//
//  AllCitiesViewController.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

protocol AllCitiesViewControllerDelegate: class {
    func didSelectCity(selectedCity: City?)
}

class AllCitiesViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.register(CitiesTableViewCell.self, forCellReuseIdentifier: String(describing: CitiesTableViewCell.self))
            self.tableView.register(UINib(nibName: String(describing: CitiesTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CitiesTableViewCell.self))
            self.tableView.separatorStyle = .singleLine
            self.tableView.backgroundColor = UIColor.lightGray1
        }
    }
    
    // MARK: - Variables
    private var cities: [City] = [] {
        didSet {
            self.tableView.reloadData()
            
            if let previousCity = previouslySelectedCity {
                if let row = self.cities.firstIndex(where: { (city) -> Bool in
                    return previousCity.id == city.id
                }) {
                    self.tableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
                }
            }
            self.previouslySelectedCity = nil
        }
    }
    weak var delegate: AllCitiesViewControllerDelegate?
    var previouslySelectedCity: City?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation Bar
        self.navigationItem.title = NSLocalizedString("cities_title", comment: "")
        
        CitiesService.getWeather { (cities) in
            self.cities = cities
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        var selectedCity: City?
        if let indexPath = self.tableView.indexPathForSelectedRow {
            selectedCity = self.cities[indexPath.row]
        }
        self.delegate?.didSelectCity(selectedCity: selectedCity)
    }
}

// MARK: - UI Table View Data Source Extension
extension AllCitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CitiesTableViewCell.self), for: indexPath) as? CitiesTableViewCell {
            cell.setupCell(city: self.cities[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UI Table View Delegate Extension
extension AllCitiesViewController: UITableViewDelegate {
    
}
