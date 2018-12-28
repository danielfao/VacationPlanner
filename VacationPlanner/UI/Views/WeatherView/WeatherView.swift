//
//  WeatherView.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

class WeatherView: BaseView {
    // MARK: - IBOutlets
    @IBOutlet weak var weatherTitleLabel: UILabel! {
        didSet {
            self.weatherTitleLabel.text = NSLocalizedString("weathers_title", comment: "")
            self.weatherTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            self.weatherTitleLabel.textColor = UIColor.DarkGray1
        }
    }
    @IBOutlet weak var selectedWeatherLabel: UILabel! {
        didSet {
            self.selectedWeatherLabel.text = NSLocalizedString("weathers_select_text", comment: "")
            self.selectedWeatherLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.selectedWeatherLabel.textColor = UIColor.lightGray3
            self.selectedWeatherLabel.textAlignment = .justified
        }
    }
    @IBOutlet weak var chevronImage: UIImageView! {
        didSet {
            self.chevronImage.image = ImageConstants.ChevronRight
            self.chevronImage.contentMode = .scaleAspectFit
            self.chevronImage.tintColor = UIColor.lightGray3
        }
    }
    
    // MARK: - Setup view
    func setup(weathers: [Weather]) {
        if weathers.isEmpty {
            self.selectedWeatherLabel.text = NSLocalizedString("weathers_select_text", comment: "")
        } else {
            self.selectedWeatherLabel.text = weathers.map({ (weather) -> String in
                return weather.name
            }).joined(separator: ", ")
        }
    }
}
