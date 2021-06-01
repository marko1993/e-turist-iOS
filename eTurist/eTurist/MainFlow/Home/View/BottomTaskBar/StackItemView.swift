//
//  TabItemCollectionViewCell.swift
//  MYTabBarDemo
//
//  Created by Abhishek Thapliyal on 25/05/20.
//  Copyright © 2020 Abhishek Thapliyal. All rights reserved.
//

import UIKit

protocol StackItemViewDelegate: class {
    func handleTap(_ view: StackItemView)
}

class StackItemView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var highlightView: UIView!
    
    private let higlightBGColor = UIColor(named: K.Color.main)
    
    static var newInstance: StackItemView {
        return Bundle.main.loadNibNamed(
            StackItemView.className(),
            owner: nil,
            options: nil
        )?.first as! StackItemView
    }
    
    weak var delegate: StackItemViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTapGesture()
    }
    
    var isSelected: Bool = false {
        willSet {
            self.updateUI(isSelected: newValue)
        }
    }
    
    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }
    
    private func configure(_ item: Any?) {
        guard let model = item as? TabBarItem else { return }
        self.titleLabel.text = model.title
        self.imgView.image = UIImage(named: model.image)?.withRenderingMode(.alwaysTemplate)
        self.isSelected = model.isSelected
    }
    
    private func updateUI(isSelected: Bool) {
        guard var model = item as? TabBarItem else { return }
        model.isSelected = isSelected
        let options: UIView.AnimationOptions = isSelected ? [.curveEaseIn] : [.curveEaseOut]
        
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.5,
                       options: options,
                       animations: {
                        self.titleLabel.text = isSelected ? model.title : ""
                        let color = isSelected ? self.higlightBGColor : UIColor.clear
                        self.highlightView.backgroundColor = color
                        self.titleLabel.textColor = isSelected ? .white : self.higlightBGColor
                        self.imgView.tintColor = isSelected ? .white : self.higlightBGColor
                        (self.superview as? UIStackView)?.layoutIfNeeded()
        }, completion: nil)
    }
    
}

extension StackItemView {
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(handleGesture(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleGesture(_ sender: UITapGestureRecognizer) {
        self.delegate?.handleTap(self)
    }
    
}
