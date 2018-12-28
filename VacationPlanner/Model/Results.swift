//
//  Results.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 28/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import Foundation

class Results {
    let date: Date
    let minTemp: Int
    let maxTemp: Int
    let weather: String
    
    init?(resultDict: [String : Any]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        guard let dateString = resultDict["date"] as? String,
            let date = dateFormatter.date(from: dateString),
            let temperature = resultDict["temperature"] as? [String : Any],
            let maxTemp = temperature["max"] as? Int,
            let minTemp = temperature["min"] as? Int,
            let weather = resultDict["weather"] as? String else {
                return nil
        }
        
        self.date = date
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.weather = weather
    }
}
