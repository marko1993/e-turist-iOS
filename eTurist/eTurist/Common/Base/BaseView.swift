//
//  BaseView.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import Foundation
import UIKit

protocol BaseView where Self: UIView {
    func addSubviews()
    func styleSubviews()
    func positionSubviews()
}

extension BaseView {
    func setupView() {
        addSubviews()
        styleSubviews()
        positionSubviews()
    }
}

