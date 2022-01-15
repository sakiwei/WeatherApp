//
//  RootRouter.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit
import SwiftUI

protocol RootRouter {
    func openSearchDialog(onSearchLocation: @escaping (String) -> Void)
    @MainActor
    func showWeather(at location: Location)
    @MainActor
    func showLocationPicker(for locations: [Location], onSelectLocation: @escaping (Location) -> Void)
}

protocol RootRouteNavigatable: AnyObject {
    func presentAlert(_ alertController: UIAlertController)
    func presentActionSheet(_ alertController: UIAlertController)
    func presentViewController(_ viewController: UIViewController)
}

final class RootRouterImpl: RootRouter {
    weak var controller: RootRouteNavigatable?

    init(controller: RootRouteNavigatable) {
        self.controller = controller
    }

    func openSearchDialog(onSearchLocation: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "Search for weather of a location", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter a location"
            textField.textAlignment = .left
            textField.font = UIFont.preferredFont(forTextStyle: .body)
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Search", style: .default, handler: { [weak alert] _ in
            guard let alert = alert else { return }
            if let searchValue = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespaces) {
                onSearchLocation(searchValue)
            }
        }))
        controller?.presentAlert(alert)
    }

    @MainActor
    func showWeather(at location: Location) {
        self.controller?.presentViewController(locationView(at: location))
    }

    private func locationView(at location: Location) -> UIViewController {
        let appService = (UIApplication.shared.delegate as! AppDelegate).appService
        return DetailModuleBuilderImpl().build(enviroment: appService!.enviroment,
                                               apiClient: appService!.apiClient, location: location)
    }

    @MainActor
    func showLocationPicker(for locations: [Location], onSelectLocation: @escaping (Location) -> Void) {
        let alert = UIAlertController(title: "Please select a location", message: nil, preferredStyle: .actionSheet)
        for location in locations {
            alert.addAction(UIAlertAction(title: "\(location.name), \(location.country ?? "")", style: .default, handler: { _ in
                onSelectLocation(location)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        controller?.presentActionSheet(alert)
    }
}
