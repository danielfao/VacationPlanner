//
//  HomeViewController.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var weatherView: WeatherView! {
        didSet {
            self.weatherView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAllWeathers)))
        }
    }
    @IBOutlet weak var citiesView: CitiesView! {
        didSet {
            self.citiesView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAllCities)))
        }
    }
    @IBOutlet weak var VacationDateView: VacationDateView!
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            self.searchButton.setTitle(NSLocalizedString("search_button_title", comment: "").uppercased(), for: .normal)
            self.searchButton.setTitleColor(UIColor.white, for: .normal)
            self.searchButton.backgroundColor = UIColor.darkGray
        }
    }
    
    // MARK: - Variables
    private var selectedWeathers: [Weather] = [] {
        didSet {
            self.verifyFields()
        }
    }
    private var selectedCity: City? {
        didSet {
            self.verifyFields()
        }
    }
    var results: [Results] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar
        self.navigationItem.title = NSLocalizedString("vacation_planner_title", comment: "")
        self.verifyFields()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
    }

    // MARK: - Functions
    @objc func didTapAllWeathers() {
        let sb = UIStoryboard(name: StoryboardName.AllWeathers)
        if let vc = sb.instantiateViewController(withIdentifier: ViewControllerName.AllWeathers) as? AllWeathersViewController {
            vc.delegate = self
            vc.previouslySelectedWeathers = self.selectedWeathers
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func didTapAllCities() {
        let sb = UIStoryboard(name: StoryboardName.AllCities)
        if let vc = sb.instantiateViewController(withIdentifier: ViewControllerName.AllCities) as? AllCitiesViewController {
            vc.delegate = self
            vc.previouslySelectedCity = self.selectedCity
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - IBActions
    @IBAction func didTapSearchButton(_ sender: Any) {
        guard let selectedCity = self.selectedCity else {
            return
        }
        ResultsService.getResults(cityId: selectedCity.id, numberOfDays: Int(self.VacationDateView.numberOfDaysStepper.value), weather: self.selectedWeathers) { (results) in
            if !results.isEmpty {
                let sb = UIStoryboard(name: StoryboardName.Results)
                if let vc = sb.instantiateViewController(withIdentifier: ViewControllerName.Results) as? ResultsViewController {
                    vc.filteredResults = results
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                let alertController = UIAlertController(title: NSLocalizedString("sorry_title", comment: ""), message: NSLocalizedString("no_result_found_text", comment: ""), preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Methods
    private func verifyFields() {
        if !self.selectedWeathers.isEmpty && self.selectedCity != nil {
            self.searchButton.isEnabled = true
        } else {
            self.searchButton.isEnabled = false
        }
    }
}

// MARK: - AllWeathersViewControllerDelegate
extension HomeViewController: AllWeathersViewControllerDelegate {
    func didSelectWeathers(selectedWeather: [Weather]) {
        self.selectedWeathers = selectedWeather
        self.weatherView.setup(weathers: selectedWeather)
    }
}

// MARK: - AllCitiesViewControllerDelegate
extension HomeViewController: AllCitiesViewControllerDelegate {
    func didSelectCity(selectedCity: City?) {
        self.selectedCity = selectedCity
        self.citiesView.setup(city: selectedCity)
    }
}
