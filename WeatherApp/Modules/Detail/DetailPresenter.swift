//
//  DetailPresenter.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

protocol DetailPresenter: AnyObject {
    func viewDidLoad()
    func fetchWeather()
}

final class DetailPresenterImpl: DetailPresenter {
    weak var view: DetailView?
    var interactor: DetailInteractor
    var router: DetailRouter
    let location: Location

    private var runningTask: Task<(), Never>?
    
    init(view: DetailView,
         interactor: DetailInteractor,
         router: DetailRouter,
         location: Location) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.location = location
    }
    
    func viewDidLoad() {
        fetchWeather()
        view?.updateLocationName(location.name)
    }

    func fetchWeather() {
        runningTask = Task { [weak self] in
            guard let self = self else { return }
            do {
                await self.view?.showLoadingIndicator()
                let result = try await self.interactor.fetchForcast(lat: location.lat,
                                                                    lon: location.lon)
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
    
    deinit {
        runningTask?.cancel()
    }
}
