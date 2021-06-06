//
//  HistoryViewController.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit
import RxSwift
import RxCocoa

class HistoryViewController: BaseViewController {
    
    private let historyView = HistoryView()
    var viewModel: HistoryViewModel!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setDelegate(for: historyView.destinationsCollectionsView)
        viewModel
            .destinationsObservable
            .observeOn(MainScheduler.instance)
            .bind(to: historyView.destinationsCollectionsView
                .rx
                .items) { cv, row, data in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: DestinationCollectionsViewCell.cellIdentifier, for: IndexPath.init(row: row, section: 0)) as! DestinationCollectionsViewCell
                
                cell.setup(with: data)
                return cell
            }.disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(historyView)
        historyView.searchBar.delegate = self
        setupBindings()
        viewModel.getVisitedDestinations()
    }
    
    private func setupBindings() {
        self.viewModel.errorRelay.asObservable().subscribe(onNext: { [weak self] error in
             if let error = error {
                 self?.presentInfoDialog(message: error)
             }
         }).disposed(by: disposeBag)
        
        self.historyView.destinationsCollectionsView.rx.itemSelected.subscribe(onNext: { indexPath in
            self.viewModel.presentDestinationDetails(index: indexPath.row)
        }).disposed(by: disposeBag)
    }
    
    func setDelegate(for collectionView: UICollectionView) {
        collectionView.delegate = nil
        collectionView.dataSource = nil
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    
    
}

extension HistoryViewController: SearchBarDelegate {
    func searchBar(_ searchBar: SearchBar, valueDidChange value: String?) {
        if let value = value {
            self.viewModel.filterDestinations(filter: value)
        }
    }
}

extension HistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 4
        let spacing:CGFloat = 12.0
        
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        
        let width = (historyView.destinationsCollectionsView.bounds.width - totalSpacing)/numberOfItemsPerRow
        return CGSize(width: width, height: 200)
    }
}


