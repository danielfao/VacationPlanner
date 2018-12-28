//
//  CitiesService.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import Foundation

class CitiesService {
    class func getWeather(completion: @escaping([City])->()) {
        NetworkService.request(type: .cities, parameters: nil) { (success, data) in
            guard let cityDicts = data as? [[String : Any]] else {
                completion([])
                return
            }
            
            var cities : [City] = []
            for cityDict in cityDicts {
                if let city = City.init(cityDict: cityDict) {
                    cities.append(city)
                }
            }
            completion(cities)
        }
    }
}
