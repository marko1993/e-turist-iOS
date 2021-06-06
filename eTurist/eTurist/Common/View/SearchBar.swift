//
//  SearchBar.swift
//  eTurist
//
//  Created by Marko on 06.06.2021..
//

import UIKit

protocol SearchBarDelegate {
    func searchBar(_ searchBar: SearchBar, valueDidChange value: String?)
}

class SearchBar: UIView, BaseView {
    
    let searchView = UIView()
    let searchImage = UIImageView(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: K.Color.main)!))
    let searchTextField = UITextField()
    let deleteImage = UIImageView(image: UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: K.Color.main)!))
    let citiesImage = UIImageView(image: UIImage(named: "location")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: K.Color.main)!))
    
    var delegate: SearchBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(citiesImage)
        addSubview(searchView)
        searchView.addSubview(searchImage)
        searchView.addSubview(searchTextField)
        searchView.addSubview(deleteImage)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        dropShadow(offsetSize: CGSize(width: 3, height: 3))
        
        deleteImage.isHidden = true
        
        searchView.backgroundColor = .white
        searchView.cornerRadius = 20
        searchView.borderColor = UIColor(named: K.Color.main)!
        searchView.borderWidth = 1
    }
    
    func positionSubviews() {
        self.constrainHeight(50)
        
        citiesImage.anchor(trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), size: CGSize(width: 40, height: 40))
        citiesImage.centerY(inView: self)
        
        searchView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: citiesImage.leadingAnchor, padding: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 8))
        
        searchImage.anchor(leading: searchView.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        searchImage.constrainHeight(16)
        searchImage.constrainWidth(16)
        searchImage.centerY(inView: searchView)
        
        deleteImage.anchor(trailing: searchView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 12))
        deleteImage.constrainHeight(16)
        deleteImage.constrainWidth(16)
        deleteImage.centerY(inView: searchView)
        
        searchTextField.anchor(top: searchView.topAnchor, leading: searchImage.trailingAnchor, bottom: searchView.bottomAnchor, trailing: deleteImage.leadingAnchor, padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        
    }
    
    func setupBindings() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(deleteTapped(tapGestureRecognizer:)))
        deleteImage.isUserInteractionEnabled = true
        deleteImage.addGestureRecognizer(tapGestureRecognizer)
        
        searchTextField.addTarget(self, action: #selector(SearchBar.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func deleteTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.clearTextField()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let value = textField.text {
            if value.isEmpty {
                self.clearTextField()
            } else {
                self.deleteImage.isHidden = false
                delegate?.searchBar(self, valueDidChange: value)
            }
        } else {
            self.searchTextField.endEditing(true)
            delegate?.searchBar(self, valueDidChange: nil)
        }
    }
    
    private func clearTextField() {
        self.searchTextField.text = ""
        self.deleteImage.isHidden = true
        self.searchTextField.endEditing(true)
        delegate?.searchBar(self, valueDidChange: "")
    }
}
