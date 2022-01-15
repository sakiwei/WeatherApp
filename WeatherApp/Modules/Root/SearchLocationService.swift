//
//  SearchLocationService.swift
//  WeatherApp
//
//  Created by Sakiwei on 15/1/2022.
//

import Foundation
import SQLite

protocol SearchLocationService {
    func searchLocation(byName name: String) throws -> [Location]?
}

final class SearchLocationServiceImpl: SearchLocationService {

    let db: Connection?

    init() {
        do {
            db = try Connection(Bundle.main.path(forResource: "data", ofType: "sqlite")!)
        } catch {
            db = nil
        }
    }

    func searchLocation(byName name: String) throws -> [Location]? {
        guard let db = db else { return nil }
        let searchValue = name.lowercased().trimmingCharacters(in: .whitespaces)
        let cities = Table("cities_20000")
        let cityName = Expression<String?>("city_name")
        let countryFull = Expression<String?>("country_full")
        let lat = Expression<String?>("lat")
        let lon = Expression<String?>("lon")
        var locationList: [Location] = []
        for city in try db.prepare(cities.filter(cityName.lowercaseString == searchValue)) {
            if let name = city[cityName],
               let lat = Double(city[lat] ?? ""),
               let lon = Double(city[lon] ?? "") {
                locationList.append(
                    Location(name: name,
                             lat: lat,
                             lon: lon,
                             country: city[countryFull]))
            }
        }
        return locationList
    }
}
