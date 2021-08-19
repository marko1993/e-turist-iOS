//
//  RouteDetailsView.swift
//  eTurist
//
//  Created by Marko on 09.08.2021..
//

import UIKit
import HCSStarRatingView

class RouteDetailsView: UIView, BaseView {
    
    private let containerHeight: CGFloat = 340.0
    private let arrowImageHeight: CGFloat = 50.0
    private let destinationsTableViewHeight: CGFloat = 220.0
    
    let routeImage = UIImageView()
    let blurView = UIView()
    let backButton = UIButton()
    let routeTitle = UILabel()
    let ratingView = RatingView()
    let starRatingView = HCSStarRatingView()
    let scrollView = UIScrollView()
    let routeDescription = UITextView()
    let commentButton = ButtonGradient()
    let startButton = ButtonGradient()
    
    let containerView = UIView()
    let arrowImage = UIImageView(image: UIImage(named: "downArrow")?.withRenderingMode(.alwaysTemplate))
    lazy var destinationsCollectionsView: UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        return cv
    }()
    
    private var shouldAnimateDestinationsDown: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(routeImage)
        addSubview(blurView)
        addSubview(backButton)
        addSubview(routeTitle)
        addSubview(starRatingView)
        addSubview(ratingView)
        addSubview(routeDescription)
        addSubview(containerView)
        containerView.addSubview(destinationsCollectionsView)
        containerView.addSubview(commentButton)
        containerView.addSubview(startButton)
        addSubview(arrowImage)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        
        self.routeImage.cornerRadius = 15
        
        self.blurView.setBlur(cornerRadius: 5)
        
        self.backButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.backButton.imageView?.tintColor = UIColor(named: K.Color.main)
        self.backButton.dropShadow(offsetSize: CGSize(width: 2, height: 2), shadowOpacity: 0.5, shadowColor: .white)
        
        self.routeTitle.font = UIFont.boldSystemFont(ofSize: 30)
        self.routeTitle.textColor = UIColor(named: K.Color.main)
        self.routeTitle.numberOfLines = 2
        self.routeTitle.dropShadow(shadowRadius: 1, offsetSize: CGSize(width: 2, height: 0), shadowOpacity: 1.0, shadowColor: .white)
        
        self.starRatingView.minimumValue = 0
        self.starRatingView.maximumValue = 5
        self.starRatingView.borderColor = UIColor(hexString: "FFD700")
        self.starRatingView.tintColor = UIColor(hexString: "FFD700")
        
        self.routeDescription.font = UIFont.systemFont(ofSize: 22.0)
        self.routeDescription.textColor = UIColor(named: K.Color.main)
        self.routeDescription.isScrollEnabled = true
        self.routeDescription.textAlignment = .justified
        self.routeDescription.isUserInteractionEnabled = true
        self.routeDescription.isEditable = false
        
        self.commentButton.setTitle(K.Strings.comment, for: .normal)
        self.commentButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        
        self.startButton.setTitle(K.Strings.start, for: .normal)
        self.startButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        
        containerView.backgroundColor = .white
        containerView.cornerRadius = 10
        containerView.dropShadow(shadowRadius: 10, offsetSize: CGSize(width: 2.0, height: 2.0), shadowOpacity: 0.5, shadowColor: .black)
        containerView.alpha = 0
        
        arrowImage.tintColor = UIColor(named: K.Color.main)
        self.arrowImage.transform = CGAffineTransform(rotationAngle: .pi)
        
        destinationsCollectionsView.delaysContentTouches = false
        destinationsCollectionsView.translatesAutoresizingMaskIntoConstraints = false
        destinationsCollectionsView.isScrollEnabled = true
        destinationsCollectionsView.showsVerticalScrollIndicator = false
        destinationsCollectionsView.showsHorizontalScrollIndicator = false
        destinationsCollectionsView.backgroundColor = .clear
        destinationsCollectionsView.isPagingEnabled = true
        destinationsCollectionsView.backgroundView?.backgroundColor = .clear
        destinationsCollectionsView.register(DestinationCollectionsViewCell.self, forCellWithReuseIdentifier: DestinationCollectionsViewCell.cellIdentifier)
    }
    
    func positionSubviews() {
        routeImage.anchor(top: self.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
        routeImage.constrainHeight(containerHeight)
        
        blurView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: safeAreaLayoutGuide.topAnchor, trailing: self.trailingAnchor)
        
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0))
        backButton.constrainWidth(30)
        backButton.constrainHeight(30)
        
        routeTitle.anchor(leading: safeAreaLayoutGuide.leadingAnchor, trailing: ratingView.leadingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15))
        routeTitle.centerY(inView: ratingView)
        
        starRatingView.anchor(top: routeImage.bottomAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        starRatingView.centerX(inView: self)
        starRatingView.constrainHeight(50)
        starRatingView.constrainWidth(200)
        
        ratingView.anchor(bottom: routeImage.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 8))
        ratingView.constrainHeight(50)
        ratingView.constrainWidth(70)
        
        containerView.anchor(top: arrowImage.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15))
        containerView.constrainHeight(containerHeight)
        
        arrowImage.anchor(bottom: safeAreaLayoutGuide.bottomAnchor)
        arrowImage.centerX(inView: containerView)
        arrowImage.constrainHeight(arrowImageHeight)
        arrowImage.constrainWidth(arrowImageHeight)
        
        commentButton.anchor(leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
        commentButton.constrainHeight(arrowImageHeight)
        commentButton.constrainWidth((UIScreen.main.bounds.width / 2.0) - 30.0)
        
        startButton.anchor(bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
        startButton.constrainHeight(arrowImageHeight)
        startButton.constrainWidth((UIScreen.main.bounds.width / 2.0) - 30.0)
        
        destinationsCollectionsView.anchor(leading: containerView.leadingAnchor, bottom: commentButton.topAnchor, trailing: containerView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
        
        destinationsCollectionsView.constrainHeight(destinationsTableViewHeight)
        
        routeDescription.anchor(top: starRatingView.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: arrowImage.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
    }
    
    func setup(with route: Route) {
        setupView()
        if let picturePath = route.picturePath {
            self.routeImage.sd_setImage(with: URL(string: K.Endpoints.imageEndpoint + picturePath))
        }
        routeTitle.text = route.name
        routeDescription.text = route.description
        starRatingView.value = CGFloat(route.myRating ?? 0)
        
        if let rating = route.averageRating {
            self.ratingView.setRating(rating: rating)
            self.ratingView.isHidden = false
        } else {
            self.ratingView.clearRating()
            self.ratingView.isHidden = true
        }
    }
    
    func animateDestinaitonsCollectionView() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear) { [weak self] in
            guard let self = self else { return }
            if (self.shouldAnimateDestinationsDown) {
                self.containerView.center.y += (self.containerHeight - self.arrowImageHeight)
                self.arrowImage.center.y += (self.containerHeight - self.arrowImageHeight)
                self.arrowImage.transform = CGAffineTransform(rotationAngle: .pi)
                self.containerView.alpha = 0
            } else {
                self.arrowImage.center.y -= (self.containerHeight - self.arrowImageHeight)
                self.containerView.center.y -= (self.containerHeight - self.arrowImageHeight)
                self.arrowImage.transform = CGAffineTransform(rotationAngle: 0)
                self.containerView.alpha = 1
            }
            self.layoutIfNeeded()
        } completion: { [weak self] isCompleted in
            self?.shouldAnimateDestinationsDown = !(self?.shouldAnimateDestinationsDown ?? true)
        }

    }
    
}
