//
//  WeatherView.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

class WeatherView: BaseView {
    // MARK: - Outlets
    @IBOutlet weak var weatherTitleLabel: UILabel! {
        didSet {
            self.weatherTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            self.weatherTitleLabel.textColor = UIColor.DarkGray1
        }
    }
    @IBOutlet weak var selectedWeatherLabel: UILabel! {
        didSet {
            self.selectedWeatherLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.selectedWeatherLabel.textColor = UIColor.lightGray3
        }
    }
    @IBOutlet weak var chevronImage: UIImageView! {
        didSet {
            self.chevronImage.image = ImageConstants.ChevronRight
            self.chevronImage.contentMode = .scaleAspectFit
            self.chevronImage.tintColor = UIColor.lightGray3
        }
    }
    
    
}
