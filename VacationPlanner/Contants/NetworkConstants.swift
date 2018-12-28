//
//  NetworkConstants.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import Foundation
import Alamofire

private struct NetworkConstants {
    static let baseURL = "http://localhost:8882/"
}

enum RequestType {
    case weather
    case cities
    case results(cityId: String, year: Int)
    
    func getURL() -> String {
        switch self {
        case .weather:
            return "\(NetworkConstants.baseURL)weather/"
        case .cities:
            return "\(NetworkConstants.baseURL)cities/"
        case .results(let cityId, let year):
            return "\(NetworkConstants.baseURL)cities/\(cityId)/year/\(year)"
        }
    }
    
    func getHTTPMethod() -> HTTPMethod {
        switch self {
        case .weather, .cities, .results(_, _):
            return .get
        }
    }
    
    func getEncoding() -> ParameterEncoding {
        switch self {
        case .weather, .cities, .results(_, _):
            return JSONEncoding.default
        }
    }
    
    func getHeaders() -> HTTPHeaders? {
        switch self {
        case .weather, .cities, .results(_, _):
            return nil
        }
    }
}
