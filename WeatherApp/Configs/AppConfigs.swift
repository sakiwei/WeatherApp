//
//  AppConfigs.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

protocol AppConfigs {
    var weatherAppId: String { get }
    var weatherApiBasePath: String { get }
}

enum Enviroment {
    case development
}

extension Enviroment: AppConfigs {

    var weatherApiBasePath: String {
        "https://api.openweathermap.org"
    }

    var weatherAppId: String {
        switch self {
        default:
            return "78a07164952e030a671b9350f648cd70"
        }
    }
}
