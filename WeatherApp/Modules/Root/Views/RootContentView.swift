//
//  RootContentView.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit
import SnapKit

final class RootContentView: UIView {

    let scrollView = UIScrollView()
    let tabView = TabView()
    let forcastDisplayView = WeatherForcastDisplayView()
    let refreshControl = UIRefreshControl()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        self.backgroundColor = .systemGroupedBackground
        addSubview(tabView)
        addSubview(scrollView)
        scrollView.addSubview(forcastDisplayView)

        createConstraints()

        scrollView.refreshControl = refreshControl
    }

    private func createConstraints() {
        tabView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(10)
            make.right.left.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(tabView.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }

        forcastDisplayView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.leftMargin.rightMargin.equalTo(self)
        }
    }
}



