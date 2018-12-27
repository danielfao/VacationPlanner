//
//  WeatherTableViewCell.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var weatherLabel: UILabel! {
        didSet {
            self.weatherLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.weatherLabel.textColor = UIColor.DarkGray1
        }
    }
    @IBOutlet weak var selectedImageView: UIImageView! {
        didSet {
            self.selectedImageView.contentMode = .scaleAspectFit
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.setSelectedStyle()
    }

    // MARK: - Setup
    func setupCell(weather: Weather) {
        self.weatherLabel.text = weather.name
    }
    
    // MARK: - Functions
    func setSelectedStyle() {
        if self.isSelected {
            self.selectedImageView.image = ImageConstants.CheckedIcon
        } else {
            self.selectedImageView.image = ImageConstants.UncheckedIcon
        }
    }
}
