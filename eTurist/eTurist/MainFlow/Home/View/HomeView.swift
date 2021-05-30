//
//  HomeView.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import UIKit

class HomeView: UIView, BaseView {
    
    let tvTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(tvTitle)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        tvTitle.text = "HOME"
    }
    
    func positionSubviews() {
        tvTitle.centerInSuperview()
    }
}
