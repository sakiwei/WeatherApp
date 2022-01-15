//
//  DailyWeatherItemView.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

final class DailyWeatherItemView: UIView {

    private let stackView = UIStackView()
    private let weatherIconView = WeatherIconView()
    private let dateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let highestTempLabel = UILabel()
    private let lowestTempLabel = UILabel()

    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d"
        return formatter
    }()

    var weather: DailyWeather? =  nil {
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
        stackView.addArrangedSubview(weatherIconView)
        let containerView = UIView()
        containerView.addSubview(dateLabel)
        containerView.addSubview(descriptionLabel)
        containerView.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        stackView.addArrangedSubview(containerView)
        stackView.addArrangedSubview(highestTempLabel)
        stackView.addArrangedSubview(lowestTempLabel)

        createConstraints()
        stylingViews()
    }

    private func createConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(6)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }

        weatherIconView.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }

        dateLabel.setContentHuggingPriority(UILayoutPriority(500), for: .vertical)
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(501), for: .vertical)

        highestTempLabel.setContentHuggingPriority(UILayoutPriority(600), for: .horizontal)
        lowestTempLabel.setContentHuggingPriority(UILayoutPriority(601), for: .horizontal)
    }

    private func stylingViews() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10

        dateLabel.textColor = .label
        descriptionLabel.textColor = .secondaryLabel
        highestTempLabel.textColor = .label
        lowestTempLabel.textColor = .label

        dateLabel.font = .preferredFont(forTextStyle: .headline)
        descriptionLabel.font = .preferredFont(forTextStyle: .subheadline)
        highestTempLabel.font = .preferredFont(forTextStyle: .body)
        lowestTempLabel.font = .preferredFont(forTextStyle: .body)

        dateLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        highestTempLabel.textAlignment = .center
        lowestTempLabel.textAlignment = .center
        highestTempLabel.textColor = .systemRed
        lowestTempLabel.textColor = .systemBlue

        descriptionLabel.numberOfLines = 0
    }

    private func updateContent() {
        if let weather = weather {
            dateLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: weather.dt))
            descriptionLabel.text = weather.weather.first?.weatherDescription
            highestTempLabel.text = "\(Int(weather.temp.max.rounded(.down)))℃"
            lowestTempLabel.text = "\(Int(weather.temp.min.rounded(.down)))℃"
            weatherIconView.icon = weather.weather.first?.icon
        } else {
            dateLabel.text = ""
            descriptionLabel.text = ""
            highestTempLabel.text = ""
            lowestTempLabel.text = ""
            weatherIconView.icon = nil
        }
    }
}

