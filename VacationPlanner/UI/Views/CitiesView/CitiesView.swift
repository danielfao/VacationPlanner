//
//  CitiesView.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

class CitiesView: BaseView {
    //MARK: - IBOutlets
    @IBOutlet weak var citiesTitleLabel: UILabel! {
        didSet {
            self.citiesTitleLabel.text = NSLocalizedString("cities_title", comment: "")
            self.citiesTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            self.citiesTitleLabel.textColor = UIColor.DarkGray1
        }
    }
    @IBOutlet weak var selectedCitiesLabel: UILabel! {
        didSet {
            self.selectedCitiesLabel.text = NSLocalizedString("cities_select_text", comment: "")
            self.selectedCitiesLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.selectedCitiesLabel.textColor = UIColor.lightGray3
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
    func setup(city: City?) {
        if let city = city {
            self.selectedCitiesLabel.text = city.formatedName
        } else {
            self.selectedCitiesLabel.text = NSLocalizedString("cities_select_text", comment: "")
        }
    }
}
