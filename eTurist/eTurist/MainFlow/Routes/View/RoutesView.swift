//
//  RoutesView.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit

class RoutesView: UIView, BaseView {
    
    let mapButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(mapButton)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        
        mapButton.setTitle("MAP", for: .normal)
        mapButton.setTitleColor(.black, for: .normal)
    }
    
    func positionSubviews() {
        mapButton.centerInSuperview()
    }
    
}
