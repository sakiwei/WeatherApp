//
//  WeatherForcastDisplayView.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit
import SnapKit

final class WeatherForcastDisplayView: UIView {

    let stackView = UIStackView()
    let nextHoursView = NextHoursForcastView()
    let nextDailyView = NextDailyForcastView()
    var isLoading = false {
        didSet {
            updateLoadingState()
        }
    }

    var weatherForcast: WeatherForcast? {
        didSet {
            updateContent()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubview(stackView)
        stackView.addArrangedSubview(nextHoursView)
        stackView.addArrangedSubview(nextDailyView)
        stackView.backgroundColor = .clear

        createConstraints()
        stylingViews()
    }

    private func createConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        nextHoursView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        nextDailyView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
    }

    private func stylingViews() {
        stackView.axis = .vertical
        stackView.spacing = 16
    }

    private func updateContent() {
        if let weatherForcast = weatherForcast {
            let timeZone = TimeZone(identifier: weatherForcast.timezone) ?? .current
            nextHoursView.setHourlyList(data: Array(weatherForcast.hourly.prefix(upTo: 4)), timeZone: timeZone)
            nextDailyView.setDailyList(data:  Array(weatherForcast.daily.prefix(upTo: 5)), timeZone: timeZone)
        } else {
            nextHoursView.clear()
            nextDailyView.clear()
        }
    }

    private func updateLoadingState() {
        nextHoursView.isLoading = isLoading
        nextDailyView.isLoading = isLoading
    }

}
