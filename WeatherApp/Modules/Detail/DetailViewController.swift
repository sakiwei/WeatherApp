//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit
import SwiftMessages

final class DetailViewController: UIViewController, ViewSafe {
    typealias ViewType = DetailContentView
    var presenter: DetailPresenter!
    var disposeBag: [Task<(), Never>] = []

    override func loadView() {
        super.loadView()
        view = createTypeSafeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()

        self.typeSafeView.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    @objc func refreshData() {
        self.presenter.fetchWeather()
    }
}

extension DetailViewController: DetailView {
    func contentDidLoad(result: WeatherForcast) {
        self.typeSafeView.forcastDisplayView.weatherForcast = result
    }

    func showLoadingIndicator() {
        self.typeSafeView.forcastDisplayView.weatherForcast = nil
        self.typeSafeView.forcastDisplayView.isLoading = true
    }

    func hideLoadingIndicator() {
        self.typeSafeView.forcastDisplayView.isLoading = false
        self.typeSafeView.refreshControl.endRefreshing()
    }

    func showError(_ message: String) {
        self.typeSafeView.forcastDisplayView.isLoading = false

        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.titleLabel?.text = message
        view.bodyLabel?.isHidden = true
        view.button?.isHidden = true
        SwiftMessages.show(view: view)
    }

    func updateLocationName(_ name: String) {
        self.title = name
    }
}

extension DetailViewController: DetailRouteNavigatable {
}
