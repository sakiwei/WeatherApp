//
//  RootView.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

protocol RootView: AnyObject {

    @MainActor
    func contentDidLoad(result: WeatherForcast)

    @MainActor
    func showLoadingIndicator()

    @MainActor
    func hideLoadingIndicator()

    @MainActor
    func showError(_ message: String)

    @MainActor
    func showMessage(_ message: String)

    func displayCityTabs(nameList: [String])
    func selectTab(at index: Int)
}
