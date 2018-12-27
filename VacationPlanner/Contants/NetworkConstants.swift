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
    
    func getURL() -> String {
        switch self {
        case .weather:
            return "\(NetworkConstants.baseURL)weather/"
        }
    }
    
    func getHTTPMethod() -> HTTPMethod {
        switch self {
        case .weather:
            return .get
        }
    }
    
    func getEncoding() -> ParameterEncoding {
        switch self {
        case .weather:
            return JSONEncoding.default
        }
    }
    
    func getHeaders() -> HTTPHeaders? {
        switch self {
        case .weather:
            return nil
        }
    }
}
