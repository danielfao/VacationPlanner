//
//  Weather.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import Foundation

class Weather: Equatable {
    let id: String
    let name: String
    
    init?(weatherDict: [String : Any]) {
        guard let id = weatherDict["id"] as? String, let name = weatherDict["name"] as? String else {
            return nil
        }
        
        self.id = id
        self.name = name.capitalized
    }
    
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        return lhs.id == rhs.id
    }
}
