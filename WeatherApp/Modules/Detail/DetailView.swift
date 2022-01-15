//
//  DetailView.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

protocol DetailView: AnyObject {

    @MainActor
    func contentDidLoad(result: WeatherForcast)

    @MainActor
    func showLoadingIndicator()

    @MainActor
    func hideLoadingIndicator()

    @MainActor
    func showError(_ message: String)

    func updateLocationName(_ name: String)
}
