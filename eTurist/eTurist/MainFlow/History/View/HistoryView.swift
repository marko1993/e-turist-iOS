//
//  HistoryView.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit

class HistoryView: UIView, BaseView {
    
    let searchBar = SearchBar(shouldShowLocationImage: false, placeholder: K.Strings.searchVisitedDestinationsPlaceholder)
    lazy var destinationsCollectionsView: UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        return cv
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(destinationsCollectionsView)
        addSubview(searchBar)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        
        destinationsCollectionsView.delaysContentTouches = false
        destinationsCollectionsView.translatesAutoresizingMaskIntoConstraints = false
        destinationsCollectionsView.isScrollEnabled = true
        destinationsCollectionsView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 90, right: 0)
        destinationsCollectionsView.showsVerticalScrollIndicator = false
        destinationsCollectionsView.backgroundColor = .clear
        destinationsCollectionsView.backgroundView?.backgroundColor = .clear
        destinationsCollectionsView.register(DestinationCollectionsViewCell.self, forCellWithReuseIdentifier: DestinationCollectionsViewCell.cellIdentifier)
    }
    
    func positionSubviews() {
        searchBar.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
        
        destinationsCollectionsView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 16, bottom: 0, right: 16))
    }
    
}
