
//
//  RootModuleBuilder.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit

protocol RootModuleBuilder {
    func build(enviroment: Enviroment,
               apiClient: APIClient) -> UIViewController
}

final class RootModuleBuilderImpl: RootModuleBuilder {
    func build(enviroment: Enviroment,
               apiClient: APIClient) -> UIViewController {
        let view = RootViewController()
        let fetchWeatherService = FetchWeatherServiceImpl(enviroment: enviroment,
                                                          apiClient: apiClient)
        let searchLocationService = SearchLocationServiceImpl()
        let interactor = RootInteractorImpl(fetchWeatherService: fetchWeatherService,
                                            searchLocationService: searchLocationService)
        let router = RootRouterImpl(controller: view)
        let defaultLocations = [
            Location(name: "Rio de Janeiro", lat: -22.90278, lon: -43.2075),
            Location(name: "London", lat: 51.50853, lon: -0.12574),
            Location(name: "Los Angeles", lat: 34.05223, lon: -118.24368)
        ]
        let presenter = RootPresenterImpl(view: view,
                                          interactor: interactor,
                                          router: router,
                                          defaultLocations: defaultLocations)
        view.presenter = presenter
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
}
