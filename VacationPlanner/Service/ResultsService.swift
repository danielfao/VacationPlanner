//
//  ResultsService.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 28/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import Foundation

class ResultsService {
    class func getResults(cityId: String, numberOfDays: Int, weather: [Weather], completion: @escaping ([[Results]]) -> ()) {
        guard let year = Calendar.current.dateComponents([.year], from: Date()).year else {
            completion([])
            return
        }
        
        let dispatchGroup = DispatchGroup()
        var currentYearResults : [Results] = []
        var nextYearResults : [Results] = []
        
        dispatchGroup.enter()
        NetworkService.request(type: .results(cityId: cityId, year: year), parameters: nil) { (success, data) in
            guard let resultDicts = data as? [[String : Any]] else {
                dispatchGroup.leave()
                return
            }
            
            let today = Date()
            for resultDict in resultDicts {
                if let result = Results.init(resultDict: resultDict), result.date.compare(today) == .orderedDescending {
                    currentYearResults.append(result)
                }
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        NetworkService.request(type: .results(cityId: cityId, year: year+1), parameters: nil) { (success, data) in
            var dateComponents = DateComponents()
            dateComponents.year = 1
            guard let resultDicts = data as? [[String : Any]], let oneYearFromNow = Calendar.current.date(byAdding: dateComponents, to: Date()) else {
                dispatchGroup.leave()
                return
            }
            
            for resultDict in resultDicts {
                if let result = Results.init(resultDict: resultDict), result.date.compare(oneYearFromNow) == .orderedAscending {
                    nextYearResults.append(result)
                }
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            let results = currentYearResults + nextYearResults
            var startIndex: Int = 0
            var count: Int = 0
            var filteredResults: [[Results]] = []
            for (index, result) in results.enumerated() {
                if weather.contains(where: { (weather) -> Bool in return result.weather.lowercased() == weather.name.lowercased() }) {
                    if count == 0 {
                        startIndex = index
                    }
                    count += 1
                } else {
                    if count >= numberOfDays {
                        var filteredResult: [Results] = []
                        for i in startIndex..<startIndex+count {
                            filteredResult.append(results[i])
                        }
                        filteredResults.append(filteredResult)
                    }
                    count = 0
                }
            }
            completion(filteredResults)
        }
    }
}
