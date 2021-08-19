//
//  RouteDetailsViewController.swift
//  eTurist
//
//  Created by Marko on 09.08.2021..
//

import UIKit
import RxSwift

class RouteDetailsViewController: BaseViewController {
    
    private let routueDetailsView = RouteDetailsView()
    var viewModel: RouteDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(routueDetailsView)
        self.routueDetailsView.setup(with: viewModel.route)
        self.setupBindings()
    }
    
    func setDelegate(for collectionView: UICollectionView) {
        collectionView.delegate = nil
        collectionView.dataSource = nil
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setupBindings() {
        
        self.setDelegate(for: routueDetailsView.destinationsCollectionsView)
        self.viewModel
            .destinationsObservable
            .observeOn(MainScheduler.instance)
            .bind(to: routueDetailsView.destinationsCollectionsView
                .rx
                .items) { cv, row, data in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: DestinationCollectionsViewCell.cellIdentifier, for: IndexPath.init(row: row, section: 0)) as! DestinationCollectionsViewCell
                
                cell.setup(with: data, shouldIndicateVisitedState: true)
                return cell
            }.disposed(by: disposeBag)
        
        self.routueDetailsView.backButton.onTap(disposeBag: disposeBag) { [weak self] in
            self?.viewModel.exitDetailsScreen()
        }
        
        self.routueDetailsView.commentButton.onTap(disposeBag: disposeBag) { [weak self] in
            self?.viewModel.showCommentsScreen()
        }
        
        self.routueDetailsView.startButton.onTap(disposeBag: disposeBag) { [weak self] in
            self?.viewModel.presentMapScreen()
        }
        
        self.routueDetailsView.arrowImage.onTap(disposeBag: disposeBag) { [weak self] in
            self?.routueDetailsView.animateDestinaitonsCollectionView()
        }
        
        self.routueDetailsView.destinationsCollectionsView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.viewModel.presentDestinationDetails(indexPath: indexPath)
        }).disposed(by: disposeBag)
        
        self.routueDetailsView.starRatingView.rx.controlEvent([.valueChanged])
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.updateRating(rating: self.routueDetailsView.starRatingView.value)
            })
            .disposed(by: disposeBag)
        
        self.viewModel.ratingObservable.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] rating in
            if let rating = rating {
                self?.routueDetailsView.starRatingView.value = CGFloat(rating.rating)
                self?.routueDetailsView.ratingView.setRating(rating: Double(rating.averageRating) ?? 0)
            }
        }).disposed(by: disposeBag)
        
    }
    
}

extension RouteDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 2
        let spacing:CGFloat = 6.0
        
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        
        let width = (routueDetailsView.destinationsCollectionsView.bounds.width - totalSpacing)/numberOfItemsPerRow
        return CGSize(width: width - 10, height: 200)
    }
}
