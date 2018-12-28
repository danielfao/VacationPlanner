//
//  City.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import Foundation

class City {
    let id: String
    let district: String
    let province: String
    let stateAcronym: String
    let country: String
    
    init?(cityDict: [String : Any]) {
        guard let id = cityDict["woeid"] as? String,
            let district = cityDict["district"] as? String,
            let province = cityDict["province"] as? String,
            let stateAcronym = cityDict["state_acronym"] as? String,
            let country = cityDict["country"] as? String else {
                return nil
        }
        
        self.id = id
        self.district = district
        self.province = province
        self.stateAcronym = stateAcronym
        self.country = country
    }
    // MARK: - Computed properties
    var formatedName: String {
        return "\(self.district), \(self.stateAcronym) - \(self.country)"
    }
}
