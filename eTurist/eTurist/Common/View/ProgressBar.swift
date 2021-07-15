//
//  ProgressBar.swift
//  eTurist
//
//  Created by Marko on 08.06.2021..
//

import UIKit

class ProgressBar: UIView, BaseView {
    
    let progresView = UIView()
    
    let backgroundViewColor: UIColor
    let progressColor: UIColor
    let viewCornerRadius: CGFloat?
    var currentProgress: CGFloat
    var progressWidthConstraint: NSLayoutConstraint?
    
    init(backgroundColor: UIColor = UIColor(named: K.Color.mainLightTransparent)!,
         progressColor: UIColor = UIColor(named: K.Color.main)!,
         cornerRadius: CGFloat? = 3,
         currentProgress: CGFloat = 0) {
        self.backgroundViewColor = backgroundColor
        self.progressColor = progressColor
        self.viewCornerRadius = cornerRadius
        self.currentProgress = currentProgress
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(progresView)
    }
    
    func styleSubviews() {
        self.backgroundColor = backgroundViewColor
        progresView.backgroundColor = progressColor
        if let cornerRadius = viewCornerRadius {
            self.cornerRadius = cornerRadius
            progresView.cornerRadius = cornerRadius
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func positionSubviews() {
        progresView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, padding: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        setProgress(currentProgress)
    }
    
    func setProgress(_ progress: CGFloat) {
        progresView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: progress).isActive = true
    }
    
}
