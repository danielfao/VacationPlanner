//
//  HomeViewController.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var weatherView: WeatherView! {
        didSet {
            self.weatherView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAllWeathers)))
        }
    }
    
    // MARK: - Variables
    private var selectedWeathers: [Weather] = []

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
}

extension HomeViewController: AllWeathersViewControllerDelegate {
    func didSelectWeathers(selectedWeather: [Weather]) {
        self.selectedWeathers = selectedWeather
        self.weatherView.setup(weathers: selectedWeather)
    }
}
