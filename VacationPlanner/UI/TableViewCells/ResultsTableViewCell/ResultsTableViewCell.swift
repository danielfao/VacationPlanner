//
//  ResultsTableViewCell.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 28/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var resultLabel: UILabel! {
        didSet {
            self.resultLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.resultLabel.textColor = UIColor.DarkGray1
        }
    }
    @IBOutlet weak var chevronImage: UIImageView! {
        didSet {
            self.chevronImage.image = ImageConstants.ChevronRight
            self.chevronImage.contentMode = .scaleAspectFit
            self.chevronImage.tintColor = UIColor.lightGray3
            self.chevronImage.isHidden = true
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.selectionStyle = .none
    }
    
    // MARK: - Setup
    func setupCell(result: [Results]) {
        guard let firstDate = result.first, let lastDate = result.last else {
            return
        }
        
        let initialDate = self.dateFormatter(date: firstDate.date)
        let endDate = self.dateFormatter(date: lastDate.date)
        
        self.resultLabel.text = "From: \(initialDate), To: \(endDate)"
    }
    
    func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "MM/dd/yyyy"
        let formattedDate = formatter.string(from: date)
        
        return formattedDate
    }
}
