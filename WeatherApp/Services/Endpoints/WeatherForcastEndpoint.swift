//
//  WeatherForcastEndpoint.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

struct WeatherForcastEndpoint: Requestable {
    let apiBaseURL: String
    let apiId: String
    let lat: Double
    let lon: Double
    
    var baseURL: String {
        return apiBaseURL
    }
    
    var path: String {
        return "/data/2.5/onecall"
    }
    
    var data: [String: String] {
        return ["lat": "\(lat)",
                "lon": "\(lon)",
                "appid": apiId,
                "units": "metric",
                "exclude": "current,minutely,alert"]
    }
    
    var method: RequestMethod {
        switch self {
        default:
            return .GET
        }
    }
    
}

