//
//  RootPresenter.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

protocol RootPresenter: AnyObject {
    func viewDidLoad()
    func onSelectLocation(byName name: String)
    func openSearch()
    func fetchWeather()
}

final class RootPresenterImpl: RootPresenter {
    weak var view: RootView?
    var interactor: RootInteractor
    var router: RootRouter
    let defaultLocations: [Location]
    
    // states
    private var selectedLocation: Location? {
        didSet {
            if let index = defaultLocations.firstIndex { location in
                location == selectedLocation
            } {
                self.view?.selectTab(at: index)
            }
        }
    }
    
    private var runningTask: Task<(), Never>?
    private var searchTask: Task<(), Never>?
    
    init(view: RootView,
         interactor: RootInteractor,
         router: RootRouter,
         defaultLocations: [Location]) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.defaultLocations = defaultLocations
    }
    
    func viewDidLoad() {
        // fetch initial city
        self.view?.displayCityTabs(nameList: self.defaultLocations.map { location in
            location.name
        })
        // initial selection
        self.selectedLocation = defaultLocations[0]
        self.fetchWeather()
    }
    
    func onSelectLocation(byName name: String) {
        if let location = defaultLocations.first(where: { location in
            location.name == name
        }) {
            self.selectedLocation = location
            self.fetchWeather()
        }
    }

    func fetchWeather() {
        runningTask = Task { [weak self] in
            guard let self = self, let selectedLocation = selectedLocation else { return }
            do {
                await self.view?.showLoadingIndicator()
                let result = try await self.interactor.fetchForcast(lat: selectedLocation.lat,
                                                                    lon: selectedLocation.lon)
                guard !Task.isCancelled else { return }
                await self.view?.contentDidLoad(result: result)
                self.runningTask = nil
                await self.view?.hideLoadingIndicator()
            } catch _ as CancellationError {
                await self.view?.hideLoadingIndicator()
            } catch {
                await self.view?.hideLoadingIndicator()
                await self.view?.showError("Unable to load data...")
            }
        }
    }

    func search(name: String) {
        searchTask = Task { [weak self] in
            guard let self = self else { return }
            do {
                let locations = try await self.interactor.search(name: name)
                if locations.count == 1 {
                    await self.router.showWeather(at: locations[0])
                } else {
                    await self.router.showLocationPicker(for: locations, onSelectLocation: { [weak self] location in
                        guard let self = self else { return }
                        Task.detached(priority: .userInitiated) {
                            await self.router.showWeather(at: location)
                        }
                    })
                }
            } catch {
                await self.view?.showMessage("Location not found...")
            }
        }
    }

    func openSearch() {
        router.openSearchDialog { [weak self] keyword in
            guard let self = self else { return }
            print("keyword = \(keyword)")
            self.search(name: keyword)
        }
    }
    
    deinit {
        runningTask?.cancel()
        searchTask?.cancel()
    }
}
