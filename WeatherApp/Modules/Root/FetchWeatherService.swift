//
//  FetchWeatherService.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

protocol FetchWeatherService {
    func fetchForcast(lat: Double, lon: Double) async throws -> WeatherForcast
}

final class FetchWeatherServiceImpl: FetchWeatherService {
    private let apiClient: APIClient
    private let enviroment: Enviroment
    
    init(enviroment: Enviroment, apiClient: APIClient) {
        self.enviroment = enviroment
        self.apiClient = apiClient
    }
    
    func fetchForcast(lat: Double, lon: Double) async throws -> WeatherForcast {
        return try await self.apiClient.getObject(createRequest(lat: lat, lon: lon))
    }
    
    private func createRequest(lat: Double, lon: Double) -> Requestable {
        WeatherForcastEndpoint(apiBaseURL: enviroment.weatherApiBasePath, apiId: enviroment.weatherAppId, lat: lat, lon: lon)
    }
}
