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
    
    // MARK: - Variables
    private var selectedWeathers: [Weather] = []
    private var selectedCity: City?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar
        self.navigationItem.title = NSLocalizedString("vacation_planner_title", comment: "")
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
