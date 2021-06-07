//
//  CityPickerTableViewCell.swift
//  eTurist
//
//  Created by Marko on 07.06.2021..
//

import UIKit

class CityPickerTableViewCell: UITableViewCell, BaseView {
    
    let radioButton = RadioButton(size: CGSize(width: 20, height: 20), tagNumber: 1)
    let cityNameLabel = UILabel()
    
    var city : City!
    var currentCityId: Int!
    
    static let cellIdentifier = "CityPickerTableViewCell"
    static let rowHeight: CGFloat = 50.0
    
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
        addSubview(radioButton)
        addSubview(cityNameLabel)
    }
    
    func styleSubviews() {
        isUserInteractionEnabled = true
        cityNameLabel.textColor = UIColor(named: K.Color.main)
        cityNameLabel.font = UIFont.systemFont(ofSize: 18)
        cityNameLabel.text = city.name
        radioButton.setChecked(currentCityId == city.id)
    }
    
    func positionSubviews() {
        radioButton.anchor(leading: self.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        radioButton.constrainWidth(20)
        radioButton.constrainHeight(20)
        radioButton.centerY(inView: self)
        
        cityNameLabel.anchor(leading: radioButton.trailingAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 16))
        cityNameLabel.centerY(inView: self)
    }
    
    func setup(with city: City, currentCityId: Int) {
        self.city = city
        self.currentCityId = currentCityId
        self.setupView()
    }

}
