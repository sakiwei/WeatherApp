//
//  WeatherIconView.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import SnapKit
import Kingfisher
import UIKit

final class WeatherIconView: UIView {

    let imageView = UIImageView()

    var icon: String? = nil {
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
        addSubview(imageView)
        createConstraints()
        stylingViews()
    }

    private func createConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func stylingViews() {
        backgroundColor = .systemBlue.withAlphaComponent(0.3)
        imageView.contentMode = .scaleAspectFit
    }

    private func updateContent() {
        imageView.kf.setImage(with: transformIconURL())
    }

    private func transformIconURL() -> URL? {
        guard let icon = icon else {
            return nil
        }
        return URL(string: "https://openweathermap.org/img/wn/\(icon)\(UIScreen.main.scale == 1 ? "" : "@\(Int(min(UIScreen.main.scale, 2)))x").png")
    }
}
