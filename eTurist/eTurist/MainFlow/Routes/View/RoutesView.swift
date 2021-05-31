//
//  RoutesView.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit

class RoutesView: UIView, BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        
    }
    
    func styleSubviews() {
        backgroundColor = .systemTeal
    }
    
    func positionSubviews() {
        
    }
    
}
