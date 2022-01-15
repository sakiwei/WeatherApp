//
//  AppServiceContainer.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

protocol AppServiceContainer {
    var enviroment: Enviroment { get }
    var apiClient: APIClient { get }
}

final class DefaultAppServiceContainer: AppServiceContainer {
    let apiClient: APIClient = makeAPIClient()
    let enviroment: Enviroment

    init(enviroment: Enviroment) {
        self.enviroment = enviroment
    }

    private static func makeAPIClient() -> APIClient {
        return DefaultAPIClient(sessionManager: makeSessionManager())
    }

    private static func makeSessionManager() -> SessionManager {
        return DefaultSessionManager()
    }
}

