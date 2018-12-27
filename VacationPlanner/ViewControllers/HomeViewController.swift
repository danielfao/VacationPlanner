//
//  ViewController.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var weatherView: WeatherView! {
        didSet {
            self.weatherView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAllWeathers)))
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar
        self.navigationItem.title = NSLocalizedString("home_title", comment: "")
    }

    // MARK: - Functions
    @objc func didTapAllWeathers() {
        let sb = UIStoryboard(name: StoryboardName.AllWeathers)
        if let vc = sb.instantiateViewController(withIdentifier: ViewControllerName.AllWeathers) as? AllWeathersViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

