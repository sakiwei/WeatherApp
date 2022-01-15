//
//  DetailContentView.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit
import SnapKit

final class DetailContentView: UIView {

    let scrollView = UIScrollView()
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
        addSubview(scrollView)
        scrollView.addSubview(forcastDisplayView)

        createConstraints()

        scrollView.refreshControl = refreshControl
    }

    private func createConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            make.right.left.bottom.equalToSuperview()
        }

        forcastDisplayView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.leftMargin.rightMargin.equalTo(self)
        }
    }
}



