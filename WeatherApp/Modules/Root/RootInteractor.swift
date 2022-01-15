//
//  RootInteractor.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

protocol RootInteractor: AnyObject {
    func fetchForcast(lat: Double, lon: Double) async throws -> WeatherForcast
    func search(name: String) async throws -> [Location]
}

enum RootInteractorError: Error {
    case locationNotFound
}

final class RootInteractorImpl: RootInteractor {
    weak var presenter: RootPresenter?
    private var fetchWeatherService: FetchWeatherService
    private var searchLocationService: SearchLocationService

    init(fetchWeatherService: FetchWeatherService, searchLocationService: SearchLocationService) {
        self.fetchWeatherService = fetchWeatherService
        self.searchLocationService = searchLocationService
    }

    func fetchForcast(lat: Double, lon: Double) async throws -> WeatherForcast {
        return try await fetchWeatherService.fetchForcast(lat: lat, lon: lon)
    }

    func search(name: String) async throws -> [Location] {
        return try await Task.detached(priority: .utility) { () -> [Location] in
            do {
                let result = try self.searchLocationService.searchLocation(byName: name)
                guard let locations = result, !locations.isEmpty else {
                    throw RootInteractorError.locationNotFound
                }
                return locations
            } catch {
                throw RootInteractorError.locationNotFound
            }
        }.value
    }
}
