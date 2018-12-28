//
//  VacationDateView.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 28/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

class VacationDateView: BaseView {
    // MARK: - IBOutlets
    @IBOutlet weak var vacationDateTitleLabel: UILabel! {
        didSet {
            self.vacationDateTitleLabel.text = NSLocalizedString("vacation_date_title", comment: "")
            self.vacationDateTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            self.vacationDateTitleLabel.textColor = UIColor.DarkGray1
        }
    }
    @IBOutlet weak var vacationTextLabel: UILabel! {
        didSet {
            self.vacationTextLabel.text = NSLocalizedString("vacation_days_text", comment: "")
            self.vacationTextLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.vacationTextLabel.textColor = UIColor.lightGray3
            self.vacationTextLabel.textAlignment = .justified
        }
    }
    @IBOutlet weak var numberOfDaysLabel: UILabel! {
        didSet {
            self.numberOfDaysLabel.text = "5 days"
            self.numberOfDaysLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.numberOfDaysLabel.textColor = UIColor.lightGray3
        }
    }
    @IBOutlet weak var numberOfDaysStepper: UIStepper! {
        didSet {
            self.numberOfDaysStepper.minimumValue = 5
            self.numberOfDaysStepper.maximumValue = 30
            self.numberOfDaysStepper.value = 5
            self.numberOfDaysStepper.tintColor = UIColor.DarkGray1
            self.numberOfDaysStepper.wraps = true
        }
    }
    
    // MARK: - IBActions
    @IBAction func numberOfDaysStepperValueChanged(_ sender: Any) {
        self.numberOfDaysLabel.text = "\(Int(self.numberOfDaysStepper.value)) days"
    }
}
