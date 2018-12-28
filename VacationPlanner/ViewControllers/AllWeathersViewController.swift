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
            self.tableView.tableHeaderView = self.searchBar
        }
    }
    
    // MARK: - Variables
    private var weathers: [Weather] = [] {
        didSet {
            self.selectedWeathers = self.weathers.filter({ (weather) -> Bool in
                return self.previouslySelectedWeathers.contains(weather)
            })
            self.previouslySelectedWeathers.removeAll()
            self.filterWith(term: "")
        }
    }
    private var filteredWeathers: [Weather] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    private var selectedWeathers: [Weather] = []
    weak var delegate: AllWeathersViewControllerDelegate?
    var previouslySelectedWeathers: [Weather] = []
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Navigation Bar
        self.navigationItem.title = NSLocalizedString("weathers_title", comment: "")
        
        WeatherService.getWeather { (weathers) in
            self.weathers = weathers
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.searchBar.frame.size.height = self.searchBar.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.delegate?.didSelectWeathers(selectedWeather: self.selectedWeathers)
    }
    
    // MARK: - Methods
    private func filterWith(term: String) {
        guard !term.isEmpty else {
            self.filteredWeathers = self.weathers
            return
        }
        self.filteredWeathers = self.weathers.filter({ (weather) -> Bool in
            return weather.name.lowercased().contains(term.lowercased())
        })
    }
}

// MARK: - Table View Data Source Extension
extension AllWeathersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredWeathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherTableViewCell.self), for: indexPath) as? WeatherTableViewCell {
            cell.setupCell(weather: self.filteredWeathers[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - Table View Delegate
extension AllWeathersViewController: UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.selectedWeathers.contains(self.filteredWeathers[indexPath.row]) {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.selectedWeathers.contains(self.filteredWeathers[indexPath.row]) {
            self.selectedWeathers.append(self.filteredWeathers[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let index = self.selectedWeathers.firstIndex(of: self.filteredWeathers[indexPath.row]) {
            self.selectedWeathers.remove(at: index)
        }
    }
}

// MARK: - UI Search Bar Delegate
extension AllWeathersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterWith(term: searchBar.text ?? "")
    }
}
