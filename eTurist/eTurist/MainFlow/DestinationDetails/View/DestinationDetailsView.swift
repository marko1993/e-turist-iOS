//
//  DestinationDetailsView.swift
//  eTurist
//
//  Created by Marko on 07.08.2021..
//

import UIKit

class DestinationDetailsView: UIView, BaseView {
    
    let destinationImage = UIImageView()
    let blurView = UIView()
    let backButton = UIButton()
    let destinationTitle = UILabel()
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
        addSubview(blurView)
        addSubview(backButton)
        addSubview(destinationTitle)
        addSubview(destinationDescription)
        addSubview(commentButton)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        
        self.destinationImage.cornerRadius = 15
        
        self.blurView.setBlur(cornerRadius: 15)
        
        self.backButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.backButton.imageView?.tintColor = UIColor(named: K.Color.main)
        
        self.destinationTitle.font = UIFont.boldSystemFont(ofSize: 30)
        self.destinationTitle.textColor = UIColor(named: K.Color.main)
        self.destinationTitle.numberOfLines = 2
        self.destinationTitle.dropShadow(shadowRadius: 5, offsetSize: CGSize(width: 3, height: 3), shadowOpacity: 0.5, shadowColor: .black)
        
        self.destinationDescription.font = UIFont.systemFont(ofSize: 22.0)
        self.destinationDescription.textColor = UIColor(named: K.Color.main)
        self.destinationDescription.isScrollEnabled = true
        self.destinationDescription.textAlignment = .justified
        
        self.commentButton.setTitle(K.Strings.comment, for: .normal)
        self.commentButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        
    }
    
    func positionSubviews() {
        
        destinationImage.anchor(top: self.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
        destinationImage.constrainHeight(350)
        
        blurView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: safeAreaLayoutGuide.topAnchor, trailing: self.trailingAnchor)
        
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0))
        backButton.constrainWidth(30)
        backButton.constrainHeight(30)
        
        destinationTitle.anchor(top: destinationImage.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15))
        
        commentButton.centerX(inView: self)
        commentButton.anchor(bottom: safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        commentButton.constrainHeight(50)
        commentButton.constrainWidth(200)
        
        destinationDescription.anchor(top: destinationTitle.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: commentButton.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15))
        
    }
    
    func setup(with destination: Destination) {
        setupView()
        if let picturePath = destination.picturePath {
            self.destinationImage.sd_setImage(with: URL(string: K.Endpoints.imageEndpoint + picturePath))
        }
        destinationTitle.text = destination.name
        destinationDescription.text = destination.description
    }
}
