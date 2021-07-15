//
//  RatingView.swift
//  eTurist
//
//  Created by Marko on 08.06.2021..
//

import UIKit

class RatingView: UIView, BaseView {
    
    let ratingLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(ratingLabel)
    }
    
    func styleSubviews() {
        self.cornerRadius = 10
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        ratingLabel.backgroundColor = UIColor(hexString: "FFD700")
        ratingLabel.textColor = .white
        ratingLabel.textAlignment = .center
        ratingLabel.contentMode = .center
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 24)
        ratingLabel.cornerRadius = 10
        ratingLabel.layer.cornerRadius = 10
        self.dropShadow(shadowRadius: 3, offsetSize: CGSize(width: 3, height: 3), shadowOpacity: 0.5, shadowColor: .black)
    }
    
    func positionSubviews() {
        ratingLabel.fillSuperview()
    }
    
    func setRating(rating: Double) {
        ratingLabel.text = String(format: "%.1f", rating)
    }
    
    func clearRating() {
        ratingLabel.text = ""
    }
    
}
