//
//  CommentsTableViewCell.swift
//  eTurist
//
//  Created by Marko on 08.08.2021..
//

import UIKit

class CommentsTableViewCell: UITableViewCell, BaseView {
    
    var comment : Comment!
    
    let commentLabel = UILabel()
    let userLabel = UILabel()
    let userAvatar = UIImageView()
    
    static let cellIdentifier = "CommentsTableViewCell"
    static let rowHeight: CGFloat = 100.0
    
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
        addSubview(userLabel)
        addSubview(commentLabel)
        addSubview(userAvatar)
    }
    
    func styleSubviews() {
        
        userLabel.font = UIFont.boldSystemFont(ofSize: 22)
        userLabel.textColor = UIColor(named: K.Color.main)
        userLabel.numberOfLines = 2
        userLabel.dropShadow(shadowRadius: 5, offsetSize: CGSize(width: 3, height: 3), shadowOpacity: 0.5, shadowColor: .black)
        
        commentLabel.font = UIFont.boldSystemFont(ofSize: 16)
        commentLabel.textColor = UIColor(named: K.Color.main)
        commentLabel.numberOfLines = 0
        
        userAvatar.cornerRadius = 35
    }
    
    func positionSubviews() {
        
        userAvatar.anchor(leading: leadingAnchor, padding: UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2))
        userAvatar.centerY(inView: self)
        userAvatar.constrainWidth(70)
        userAvatar.constrainHeight(70)
        
        userLabel.anchor(top: topAnchor, leading: userAvatar.trailingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 2, left: 10, bottom: 0, right: 10))
        
        commentLabel.anchor(top: userLabel.bottomAnchor, leading: userAvatar.trailingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10))
    }
    
    func setup(with comment: Comment) {
        self.setupView()
        userLabel.text = comment.fullName
        commentLabel.text = comment.comment
        if let picturePath = comment.picturePath {
            userAvatar.sd_setImage(with: URL(string: K.Endpoints.imageEndpoint + picturePath))
        } else {
            userAvatar.image = UIImage(named: "profilePlaceholder")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: K.Color.main)!)
        }
    }

}
