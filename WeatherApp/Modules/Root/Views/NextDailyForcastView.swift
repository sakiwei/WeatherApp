//
//  NextDailyForcastView.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit
import SnapKit

final class NextDailyForcastView: UIView {

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let titleLabel = UILabel()
    let seperator = UIView()
    var isLoading = false {
        didSet {
            updateLabel()
        }
    }

    private var dailyList: [DailyWeather] = [] {
        didSet {
            updateList()
        }
    }
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
        addSubview(stackView)
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

        stackView.snp.makeConstraints { make in
            make.top.equalTo(seperator.snp.bottom).offset(10)
            make.bottom.left.right.equalToSuperview().inset(10)
        }
    }

    private func stylingViews() {
        backgroundColor = .systemBackground

        self.layer.borderColor = UIColor.systemGray3.cgColor
        self.layer.borderWidth = 1

        seperator.backgroundColor = .systemGray3

        stackView.axis = .vertical
        stackView.spacing = 10

        titleLabel.textColor = .label
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        titleLabel.numberOfLines = 0
    }

    private func updateList() {
        stackView.arrangedSubviews.forEach { view in
            stackView.removeArrangedSubview(view)
            NSLayoutConstraint.deactivate(view.constraints)
            view.removeFromSuperview()
        }

        dailyList.forEach { weather in
            let weatherView = DailyWeatherItemView()
            weatherView.dateFormatter.timeZone = timeZone
            weatherView.weather = weather
            stackView.addArrangedSubview(weatherView)
        }
    }

    private func updateLabel() {
        let attrString = NSMutableAttributedString(string: "Next 5 days",
                                                   attributes: [.foregroundColor: UIColor.label,
                                                                .font: UIFont.preferredFont(forTextStyle: .largeTitle)])
        if isLoading {
            attrString.append(NSMutableAttributedString(string: "\nLoading...",
                                                        attributes: [.foregroundColor: UIColor.secondaryLabel,
                                                                     .font: UIFont.preferredFont(forTextStyle: .body)]))
        }
        titleLabel.attributedText = attrString
    }

    func setDailyList(data: [DailyWeather], timeZone: TimeZone) {
        self.dailyList = data
        self.timeZone = timeZone
        self.updateList()
    }

    func clear() {
        self.timeZone = TimeZone.current
        self.dailyList = []
        self.updateList()
    }
}

