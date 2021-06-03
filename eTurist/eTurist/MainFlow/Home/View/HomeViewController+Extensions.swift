//
//  HomeViewController+BaseView.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit

extension HomeViewController {
    
    func configurePageViewController() {
        self.delegate = nil
        self.delegate = self
        self.dataSource = nil;
        self.dataSource = self;
        self.setViewControllers([tabBarItems[0].viewController], direction: .forward, animated: true)
    }
    
    func configureBotomNavigation() {
        view.addSubview(bottomTabContainer)
        view.addSubview(bottomBarTab)
        bottomTabContainer.anchor(leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        bottomTabContainer.constrainHeight(80)
        bottomTabContainer.constrainWidth(UIScreen.main.bounds.size.width)
        bottomTabContainer.cornerRadius = 30
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bottomTabContainer.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bottomTabContainer.addSubview(blurEffectView)
        
        bottomBarTab.axis = .horizontal
        bottomBarTab.alignment = .fill
        bottomBarTab.contentMode = .scaleToFill
        bottomBarTab.distribution = .equalSpacing
        bottomBarTab.spacing = 0
        bottomBarTab.anchor(leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25))
        bottomBarTab.constrainHeight(70)
        bottomBarTab.centerY(inView: bottomTabContainer)
        bottomBarTab.constrainWidth(UIScreen.main.bounds.size.width)
        self.setupTabs()
    }
    
}
