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
    
    let backgroundView = UIView()
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
        addSubview(backgroundView)
        addSubview(containerView)
        containerView.addSubview(commentsTableView)
        containerView.addSubview(addCommentView)
        addCommentView.addSubview(commentTextField)
        addCommentView.addSubview(addCommentButton)
    }
    
    func styleSubviews() {
        self.backgroundColor = .clear
        
        backgroundView.backgroundColor = UIColor(named: K.Color.backgroundDarkTransparent)
        
        containerView.backgroundColor = .white
        containerView.cornerRadius = 15
        containerView.dropShadow(shadowRadius: 15, shadowColor: .white)
        containerView.isHidden = true
        
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
        backgroundView.fillSuperview()
        
        containerView.anchor(leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
        containerView.constrainHeight(UIScreen.main.bounds.height * 0.7)
        
        addCommentView.anchor(leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 10, bottom: 10, right: 10))
        
        addCommentView.constrainHeight(50)
        
        addCommentButton.anchor(trailing: addCommentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 16))
        addCommentButton.constrainHeight(25)
        addCommentButton.constrainWidth(25)
        addCommentButton.centerY(inView: addCommentView)
        
        commentTextField.anchor(top: addCommentView.topAnchor, leading: addCommentView.leadingAnchor, bottom: addCommentView.bottomAnchor, trailing: addCommentButton.leadingAnchor, padding: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 8))
        
        commentsTableView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: addCommentView.topAnchor, trailing: containerView.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
    }
    
    func animateContainerView(direction: AnimationDirection, duration: TimeInterval = 0.5, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear) { [weak self] in
            switch direction {
            case .up:
                self?.containerView.center.y -= (self?.containerView.bounds.height)!
            case .down:
                self?.containerView.center.y += (self?.containerView.bounds.height)!
            }
            self?.layoutIfNeeded()
        } completion: { isCompleted in
            if isCompleted && completion != nil {
                completion!()
            }
        }

    }
    
}
