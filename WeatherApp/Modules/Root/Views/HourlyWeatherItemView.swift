//
//  HourlyWeatherItemView.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

final class HourlyWeatherItemView: UIView {

    private let stackView = UIStackView()
    private let tempLabel = UILabel()
    private let humidityLabel = UILabel()
    private let weatherIconView = WeatherIconView()
    private let timeLabel = UILabel()

    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

    var weather: HourlyWeather? =  nil {
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
        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(humidityLabel)
        stackView.addArrangedSubview(weatherIconView)
        stackView.addArrangedSubview(timeLabel)

        createConstraints()
        stylingViews()
    }

    private func createConstraints() {
        snp.makeConstraints { make in
            make.width.equalTo(80)
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        weatherIconView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }

        tempLabel.setContentHuggingPriority(UILayoutPriority(500), for: .vertical)
        humidityLabel.setContentHuggingPriority(UILayoutPriority(501), for: .vertical)
        weatherIconView.setContentHuggingPriority(UILayoutPriority(600), for: .vertical)
        weatherIconView.setContentHuggingPriority(UILayoutPriority(502), for: .vertical)
    }

    private func stylingViews() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10

        tempLabel.textColor = .label
        humidityLabel.textColor = .systemBlue
        timeLabel.textColor = .secondaryLabel

        timeLabel.font = .preferredFont(forTextStyle: .body)
        humidityLabel.font = .preferredFont(forTextStyle: .body)
        timeLabel.font = .preferredFont(forTextStyle: .body)
    }

    private func updateContent() {
        if let weather = weather {
            tempLabel.text = "\(Int(weather.temp.rounded(.down)))℃"
            humidityLabel.text = "\(weather.humidity)%"
            timeLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: weather.dt - Double()))
            weatherIconView.icon = weather.weather.first?.icon
        } else {
            tempLabel.text = ""
            humidityLabel.text = ""
            timeLabel.text = ""
            weatherIconView.icon = nil
        }
    }
}

