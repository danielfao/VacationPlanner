//
//  WeatherService.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import Foundation

class WeatherService {
    class func getWeather(completion: @escaping ([Weather]) -> ()) {
        NetworkService.request(type: .weather, parameters: nil) { (success, data) in
            guard let weatherDicts = data as? [[String : Any]] else {
                completion([])
                return
            }
            
            var weathers : [Weather] = []
            for weatherDict in weatherDicts {
                if let weather = Weather.init(weatherDict: weatherDict) {
                    weathers.append(weather)
                }
            }
            completion(weathers)
        }
    }
    
}
