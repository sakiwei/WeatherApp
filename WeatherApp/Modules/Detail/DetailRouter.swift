//
//  DetailRouter.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

protocol DetailRouter {

}

protocol DetailRouteNavigatable: AnyObject {

}

final class DetailRouterImpl: DetailRouter {
    weak var controller: DetailRouteNavigatable?

    init(controller: DetailRouteNavigatable) {
        self.controller = controller
    }
}
