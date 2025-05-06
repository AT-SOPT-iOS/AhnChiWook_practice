//
//  UIView+.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 4/20/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
