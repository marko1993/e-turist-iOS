//
//  RoutesView.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit

class RoutesView: UIView, BaseView {
    
    var routesTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(routesTableView)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        
        routesTableView.backgroundColor = .clear
        routesTableView.rowHeight = RoutesTableViewCell.rowHeight
        routesTableView.separatorStyle = .none
        routesTableView.showsVerticalScrollIndicator = false
        routesTableView.contentInsetAdjustmentBehavior = .never
        routesTableView.allowsSelection = false
        
        routesTableView.tableHeaderView = nil
        routesTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        
        routesTableView.register(RoutesTableViewCell.self, forCellReuseIdentifier: RoutesTableViewCell.cellIdentifier)
        
    }
    
    func positionSubviews() {
        routesTableView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 70, left: 16, bottom: 0, right: 16))
    }
    
}
