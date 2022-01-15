//
//  DetailModuleBuilder.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit

protocol DetailModuleBuilder {
    func build(enviroment: Enviroment,
               apiClient: APIClient,
               location: Location) -> UIViewController
}

final class DetailModuleBuilderImpl: DetailModuleBuilder {
    func build(enviroment: Enviroment,
               apiClient: APIClient,
               location: Location) -> UIViewController {
        let view = DetailViewController()
        let service = FetchWeatherServiceImpl(enviroment: enviroment,
                                              apiClient: apiClient)
        let interactor = DetailInteractorImpl(service: service)
        let router = DetailRouterImpl(controller: view)
        let presenter = DetailPresenterImpl(view: view,
                                            interactor: interactor,
                                            router: router,
                                            location: location)
        view.presenter = presenter
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
}
