//
//  UIBarButton+Shorthands.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation
import UIKit

public extension UIBarButtonItem {
    convenience init(imageSystemName: String,
                     style: UIBarButtonItem.Style,
                     target: Any?,
                     action: Selector?) {
        let icon = UIImage(systemName: imageSystemName)
        self.init(image: icon,
                  style: style,
                  target: target,
                  action: action)
    }
}
