//
//  DetailInteractor.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

protocol DetailInteractor: AnyObject {
    func fetchForcast(lat: Double, lon: Double) async throws -> WeatherForcast
}

final class DetailInteractorImpl: DetailInteractor {
    weak var presenter: DetailPresenter?
    private var service: FetchWeatherService

    init(service: FetchWeatherService) {
        self.service = service
    }

    func fetchForcast(lat: Double, lon: Double) async throws -> WeatherForcast {
        return try await service.fetchForcast(lat: lat, lon: lon)
    }
}
