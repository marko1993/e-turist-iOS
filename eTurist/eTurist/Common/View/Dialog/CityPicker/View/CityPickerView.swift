//
//  CityPickerView.swift
//  eTurist
//
//  Created by Marko on 07.06.2021..
//

import UIKit

class CityPickerView: UIView, BaseView {
    
    let backgroundView = UIView()
    let container = UIView()
    let titleLabel = UILabel()
    let citiesTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(backgroundView)
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(citiesTableView)
    }
    
    func styleSubviews() {
        backgroundColor = .clear
        backgroundView.backgroundColor = UIColor(named: K.Color.backgroundDarkTransparent)
        
        container.backgroundColor = .white
        container.cornerRadius = 20
        container.dropShadow(shadowColor: .black)
        
        titleLabel.textColor = UIColor(named: K.Color.main)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.text = K.Strings.selectCity
        titleLabel.textAlignment = .center
        
        citiesTableView.backgroundColor = .clear
        citiesTableView.rowHeight = CityPickerTableViewCell.rowHeight
        citiesTableView.separatorStyle = .none
        citiesTableView.showsVerticalScrollIndicator = false
        citiesTableView.contentInsetAdjustmentBehavior = .never
        
        citiesTableView.tableHeaderView = nil
        
        citiesTableView.register(CityPickerTableViewCell.self, forCellReuseIdentifier: CityPickerTableViewCell.cellIdentifier)
    }
    
    func positionSubviews() {
        
        backgroundView.fillSuperview()
        
        container.centerInSuperview()
        container.constrainHeight(250)
        container.anchor(leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        titleLabel.anchor(top: container.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 16, bottom: 0, right: 16))
        titleLabel.centerX(inView: container)
        
        citiesTableView.anchor(top: titleLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16))
        
    }
    
    
}
