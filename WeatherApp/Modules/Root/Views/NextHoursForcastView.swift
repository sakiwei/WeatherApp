//
//  NextHoursForcastView.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit
import SnapKit

final class NextHoursForcastView: UIView {

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let titleLabel = UILabel()
    let seperator = UIView()
    var isLoading = false {
        didSet {
            updateLabel()
        }
    }

    private var hourlyList: [HourlyWeather] = []

    private var timeZone: TimeZone = TimeZone.current

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubview(titleLabel)
        addSubview(seperator)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        createConstraints()
        stylingViews()

        updateLabel()
    }

    private func createConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(10)
        }
        seperator.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
            make.top.equalTo(seperator.snp.bottom).offset(10)
            make.height.equalTo(120)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(120)
            make.left.right.equalTo(scrollView).inset(16)
        }
    }

    private func stylingViews() {
        backgroundColor = .systemBackground

        self.layer.borderColor = UIColor.systemGray3.cgColor
        self.layer.borderWidth = 1

        seperator.backgroundColor = .systemGray3

        stackView.axis = .horizontal
        stackView.spacing = 10

        titleLabel.textColor = .label
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        titleLabel.numberOfLines = 0

        scrollView.showsHorizontalScrollIndicator = false
    }

    private func updateList() {
        stackView.arrangedSubviews.forEach { view in
            stackView.removeArrangedSubview(view)
            NSLayoutConstraint.deactivate(view.constraints)
            view.removeFromSuperview()
        }

        hourlyList.forEach { weather in
            let weatherView = HourlyWeatherItemView()
            weatherView.dateFormatter.timeZone = timeZone
            weatherView.weather = weather
            stackView.addArrangedSubview(weatherView)
        }
    }

    private func updateLabel() {
        let attrString = NSMutableAttributedString(string: "Next hours",
                                                   attributes: [.foregroundColor: UIColor.label,
                                                                .font: UIFont.preferredFont(forTextStyle: .largeTitle)])
        if isLoading {
            attrString.append(NSMutableAttributedString(string: "\nLoading...",
                                                        attributes: [.foregroundColor: UIColor.secondaryLabel,
                                                                     .font: UIFont.preferredFont(forTextStyle: .body)]))
        }
        titleLabel.attributedText = attrString
    }

    func setHourlyList(data: [HourlyWeather], timeZone: TimeZone) {
        self.hourlyList = data
        self.timeZone = timeZone
        self.updateList()
    }

    func clear() {
        self.timeZone = TimeZone.current
        self.hourlyList = []
        self.updateList()
    }
}
