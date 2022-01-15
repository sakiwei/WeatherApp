//
//  RootViewController.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit
import SwiftMessages

final class RootViewController: UIViewController, ViewSafe {
    typealias ViewType = RootContentView
    var presenter: RootPresenter!
    var disposeBag: [Task<(), Never>] = []

    override func loadView() {
        super.loadView()
        view = createTypeSafeView()
        showSearchButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        self.title = "Weather Forcast"

        self.typeSafeView.tabView.onSelectTab = { [weak self] name in
            guard let self = self else { return }
            print(name)
            self.presenter?.onSelectLocation(byName: name)
        }

        self.typeSafeView.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    @objc func search() {
        self.presenter.openSearch()
    }

    @objc func refreshData() {
        self.presenter.fetchWeather()
    }

    private func showSearchButton() {
        let barButtonItem = UIBarButtonItem(imageSystemName: "magnifyingglass",
                                            style: .plain,
                                            target: self,
                                            action: #selector(search))
        barButtonItem.accessibilityIdentifier = "Search"
        navigationItem.rightBarButtonItem = barButtonItem
    }
}

extension RootViewController: RootView {
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

    func showMessage(_ message: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.info)
        view.titleLabel?.text = message
        view.bodyLabel?.isHidden = true
        view.button?.isHidden = true
        SwiftMessages.show(view: view)
    }

    func displayCityTabs(nameList: [String]) {
        self.typeSafeView.tabView.nameList = nameList
    }

    func selectTab(at index: Int) {
        self.typeSafeView.tabView.selectedIndex = index
    }
}

extension RootViewController: RootRouteNavigatable {
    func presentViewController(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }

    func presentAlert(_ alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }

    func presentActionSheet(_ alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
}
