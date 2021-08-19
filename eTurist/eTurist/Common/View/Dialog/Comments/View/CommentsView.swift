//
//  CommentsView.swift
//  eTurist
//
//  Created by Marko on 08.08.2021..
//

import UIKit

enum AnimationDirection {
    case up, down
}

class CommentsView: UIView, BaseView {
    
    let containerView = UIView()
    let commentsTableView = UITableView()
    let addCommentView = UIView()
    let commentTextField = UITextField()
    let addCommentButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(commentsTableView)
        containerView.addSubview(addCommentView)
        addCommentView.addSubview(commentTextField)
        addCommentView.addSubview(addCommentButton)
    }
    
    func styleSubviews() {
        self.backgroundColor = .clear
 
        containerView.backgroundColor = .white
        containerView.cornerRadius = 15
        containerView.dropShadow(shadowRadius: 15, shadowColor: .white)
        
        commentsTableView.backgroundColor = .clear
        commentsTableView.rowHeight = CommentsTableViewCell.rowHeight
        commentsTableView.separatorStyle = .none
        commentsTableView.showsVerticalScrollIndicator = false
        commentsTableView.contentInsetAdjustmentBehavior = .never
        commentsTableView.allowsSelection = false
        
        commentsTableView.tableHeaderView = nil
        
        commentsTableView.register(CommentsTableViewCell.self, forCellReuseIdentifier: CommentsTableViewCell.cellIdentifier)
        
        commentTextField.textColor = UIColor(named: K.Color.main)
        commentTextField.attributedPlaceholder = NSAttributedString(string: K.Strings.addCommentPlaceholder,
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: K.Color.mainTransparent)!])
        
        addCommentView.backgroundColor = .white
        addCommentView.cornerRadius = 25
        addCommentView.borderColor = UIColor(named: K.Color.main)!
        addCommentView.borderWidth = 1
        
        addCommentButton.setImage(UIImage(named: "addComment")?.withTintColor(UIColor(named: K.Color.main)!), for: .normal)
    }
    
    func positionSubviews() {
        containerView.fillSuperview()
        
        addCommentView.anchor(leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 40, right: 10))
        
        addCommentView.constrainHeight(50)
        
        addCommentButton.anchor(trailing: addCommentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 16))
        addCommentButton.constrainHeight(25)
        addCommentButton.constrainWidth(25)
        addCommentButton.centerY(inView: addCommentView)
        
        commentTextField.anchor(top: addCommentView.topAnchor, leading: addCommentView.leadingAnchor, bottom: addCommentView.bottomAnchor, trailing: addCommentButton.leadingAnchor, padding: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 8))
        
        commentsTableView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: addCommentView.topAnchor, trailing: containerView.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
    }
    
}
