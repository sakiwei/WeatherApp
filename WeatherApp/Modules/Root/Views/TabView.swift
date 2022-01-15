//
//  TabView.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit
import SnapKit

final class TabView: UIView {

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var tabButtons: [UIButton] = []

    var nameList: [String] = [] {
        didSet {
            updateTabs()
        }
    }

    var selectedIndex: Int = 0 {
        didSet {
            updateSelection()
        }
    }

    var onSelectTab: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        self.backgroundColor = .systemBackground
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        createConstraints()
        stylingViews()
    }

    private func createConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.left.right.equalTo(scrollView).inset(16)
        }
    }

    private func stylingViews() {
        backgroundColor = .systemGray6

        stackView.axis = .horizontal
        stackView.spacing = 10
    }

    private func updateTabs() {
        stackView.arrangedSubviews.forEach { view in
            stackView.removeArrangedSubview(view)
        }

        let buttons = nameList.map { title -> UIButton in
            let button = UIButton(frame: .zero)
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(onClickTab(sender:)), for: .touchUpInside)
            button.setTitleColor(.systemGray2, for: .normal)
            button.setTitleColor(.systemBlue, for: .selected)
            return button
        }

        buttons.forEach { (button) in
            stackView.addArrangedSubview(button)
        }

        tabButtons = buttons
    }

    private func updateSelection() {
        for (index, button) in tabButtons.enumerated() {
            button.isSelected = selectedIndex == index
        }
    }

    @objc func onClickTab(sender: UIButton) {
        if let title = sender.title(for: .normal) {
            onSelectTab?(title)
        }
    }
}



