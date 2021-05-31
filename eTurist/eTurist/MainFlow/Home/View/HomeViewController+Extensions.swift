//
//  HomeViewController+BaseView.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit

extension HomeViewController {
    
    func configurePageViewController() {
        self.dataSource = nil;
        self.dataSource = self;
        self.setViewControllers([tabBarItems[0].viewController], direction: .forward, animated: true)
    }
    
    func configureBotomNavigation() {
        view.addSubview(bottomTabContainer)
        view.addSubview(bottomBarTab)
        bottomTabContainer.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        bottomTabContainer.constrainHeight(80)
        bottomTabContainer.constrainWidth(UIScreen.main.bounds.size.width)
        bottomTabContainer.backgroundColor = .white
        
        bottomBarTab.axis = .horizontal
        bottomBarTab.alignment = .fill
        bottomBarTab.contentMode = .scaleToFill
        bottomBarTab.distribution = .equalSpacing
        bottomBarTab.spacing = 0
        bottomBarTab.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25))
        bottomBarTab.constrainHeight(70)
        bottomBarTab.constrainWidth(UIScreen.main.bounds.size.width)
        self.setupTabs()
    }
    
}
