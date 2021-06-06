//
//  DestinationCollectionsViewCell.swift
//  eTurist
//
//  Created by Marko on 06.06.2021..
//

import UIKit

class DestinationCollectionsViewCell: UICollectionViewCell, BaseView {
    
    let gradientView = UIView()
    let destinationImage = UIImageView()
    let destinationName = UILabel()
    let destinationDescriptrion = UILabel()
    
    var destination: Destination!
    static let cellIdentifier = "DestinationCollectionsViewCell"
    
    func addSubviews() {
        addSubview(destinationImage)
        addSubview(gradientView)
        addSubview(destinationName)
        addSubview(destinationDescriptrion)
    }

    func styleSubviews() {
        self.destinationName.font = UIFont.boldSystemFont(ofSize: 14)
        self.destinationDescriptrion.font = UIFont.systemFont(ofSize: 10.0)
        
        self.destinationName.textColor = .white
        self.destinationDescriptrion.textColor = .white
        
        self.destinationName.numberOfLines = 2
        self.destinationDescriptrion.numberOfLines = 0
        
        destinationImage.cornerRadius = 15
        
        addGradientToView(gradientView, colors: [UIColor.black.withAlphaComponent(0.2).cgColor, UIColor.black.withAlphaComponent(0.7).cgColor], cornerRadius: 15, frame: self.bounds)
        
        self.isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = false
        
        backgroundColor = .white
        self.cornerRadius = 15
        self.dropShadow(offsetSize: CGSize(width: 3, height: 3))
    }
    
    func positionSubviews() {
        destinationImage.fillSuperview()
        
        gradientView.anchor(leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        gradientView.constrainHeight(100)
        
        self.destinationName.anchor(leading: self.leadingAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4))
        destinationName.centerY(inView: self)
        
        destinationDescriptrion.anchor(top: destinationName.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4))
    }
    
    func setup(with destination: Destination) {
        self.destination = destination
        self.destinationName.text = destination.name
        self.destinationDescriptrion.text = destination.description
        self.setupView()
        if let picturePath = destination.picturePath {
            destinationImage.sd_setImage(with: URL(string: K.Endpoints.imageEndpoint + picturePath)) {[weak self] (image, error, cache, url) in
                self?.gradientView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
            }
        }
    }
    
    private func addGradientToView(_ view: UIView, colors: [CGColor], cornerRadius: CGFloat, frame: CGRect) {
        view.layer.sublayers?.removeAll()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
