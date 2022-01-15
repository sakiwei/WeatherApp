//
//  Location.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

struct Location {
    var name: String
    var lat: Double
    var lon: Double
    var country: String?
}

extension Location: Equatable {

}
