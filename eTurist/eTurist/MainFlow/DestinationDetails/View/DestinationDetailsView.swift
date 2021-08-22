//
//  DestinationDetailsView.swift
//  eTurist
//
//  Created by Marko on 07.08.2021..
//

import UIKit

class DestinationDetailsView: UIView, BaseView {
    
    let destinationImage = UIImageView()
    let scrollView = UIScrollView()
    let destinationDescription = UITextView()
    let commentButton = ButtonGradient()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(destinationImage)
        addSubview(destinationDescription)
        addSubview(commentButton)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        
        self.destinationImage.cornerRadius = 15
        
        self.destinationDescription.font = UIFont.systemFont(ofSize: 22.0)
        self.destinationDescription.textColor = UIColor(named: K.Color.main)
        self.destinationDescription.isScrollEnabled = true
        self.destinationDescription.textAlignment = .justified
        self.destinationDescription.isUserInteractionEnabled = true
        self.destinationDescription.isEditable = false
        
        self.commentButton.setTitle(K.Strings.comment, for: .normal)
        self.commentButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        
    }
    
    func positionSubviews() {
        
        destinationImage.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20))
        destinationImage.constrainHeight(270)
        
        commentButton.centerX(inView: self)
        commentButton.anchor(bottom: safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        commentButton.constrainHeight(50)
        commentButton.constrainWidth(200)
        
        destinationDescription.anchor(top: destinationImage.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: commentButton.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15))
        
    }
    
    func setup(with destination: Destination) {
        setupView()
        if let picturePath = destination.picturePath {
            self.destinationImage.sd_setImage(with: URL(string: K.Endpoints.imageEndpoint + picturePath))
        }
        destinationDescription.text = destination.description
    }
}
