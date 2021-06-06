//
//  RoutesTableViewCell.swift
//  eTurist
//
//  Created by Marko on 06.06.2021..
//

import UIKit
import RxSwift
import RxCocoa

protocol RoutesTableViewCellDelegate {
    func routesTableViewCell(_ cell: RoutesTableViewCell, didPressPlayButtonFor route: Route)
    func routesTableViewCell(_ cell: RoutesTableViewCell, didSelectCellFor route: Route)
}

class RoutesTableViewCell: UITableViewCell, BaseView {
    
    let containerView = UIView()
    let routeImage = UIImageView()
    let playImage = UIImageView(image: UIImage(named: "play")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: K.Color.main)!))
    let routeName = UILabel()
    let routeDescriptrion = UILabel()
    
    var route : Route!
    var delegate: RoutesTableViewCellDelegate?
    
    static let cellIdentifier = "RoutesTableViewCell"
    static let rowHeight: CGFloat = 300.0
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 8
            frame.size.height -= 2 * 9
            frame.origin.x += 15
            frame.size.width -= 2 * 16
            super.frame = frame
        }
    }
    
    func addSubviews() {
        addSubview(containerView)
        addSubview(routeImage)
        addSubview(playImage)
        addSubview(routeName)
        addSubview(routeDescriptrion)
    }
    
    func styleSubviews() {
        
        self.routeName.font = UIFont.boldSystemFont(ofSize: 18)
        self.routeDescriptrion.font = UIFont.systemFont(ofSize: 16.0)
        
        self.routeName.textColor = UIColor(named: K.Color.main)
        self.routeDescriptrion.textColor = UIColor(named: K.Color.main)
        
        self.routeName.numberOfLines = 2
        self.routeDescriptrion.numberOfLines = 0
        
        self.isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = false
        
        backgroundColor = .white
        self.cornerRadius = 15
        self.dropShadow()
        routeImage.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    
    func positionSubviews() {
        routeImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor)
        routeImage.constrainHeight(200)
        
        containerView.fillSuperview()
        
        playImage.anchor(top: routeImage.bottomAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 8))
        playImage.constrainWidth(60)
        
        routeName.anchor(top: routeImage.bottomAnchor, leading: self.leadingAnchor, trailing: playImage.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        routeName.constrainHeight(30)
        
        routeDescriptrion.anchor(top: routeName.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: playImage.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    }
    
    func setupBindings(disposeBag: DisposeBag) {
        self.containerView.onTap(disposeBag: disposeBag) { [weak self] in
            guard let self = self else { return }
            self.delegate?.routesTableViewCell(self, didSelectCellFor: self.route)
        }
        
        self.playImage.onTap(disposeBag: disposeBag) { [weak self] in
            guard let self = self else { return }
            self.delegate?.routesTableViewCell(self, didPressPlayButtonFor: self.route)
        }
    }
    
    func setup(with route: Route, delegate: RoutesTableViewCellDelegate? = nil) {
        self.route = route
        self.delegate = delegate
        self.routeName.text = route.name
        self.routeDescriptrion.text = route.description
        self.setupView()
        if let picturePath = route.picturePath {
            routeImage.sd_setImage(with: URL(string: K.Endpoints.imageEndpoint + picturePath)) { [weak self] (image, error, cache, url) in
                self?.routeImage.roundCorners(corners: [.topLeft, .topRight], radius: 15)
            }
            
        }
    }
    
}
