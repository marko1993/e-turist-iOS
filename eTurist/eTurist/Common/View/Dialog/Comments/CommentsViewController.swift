//
//  CommentsViewController.swift
//  eTurist
//
//  Created by Marko on 08.08.2021..
//

import UIKit
import RxSwift
import RxCocoa

class CommentsViewController: BaseViewController {
    
    private let commentsView = CommentsView()
    var viewModel: CommentsViewModel!
    var firstLoad = true
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if firstLoad {
            firstLoad = false
            viewModel?
                .commentsObservable
                .observeOn(MainScheduler.instance)
                .bind(to:
                        commentsView.commentsTableView
                        .rx
                        .items(
                            cellIdentifier: CommentsTableViewCell.cellIdentifier,
                            cellType: CommentsTableViewCell.self)) { index, data, cell in
                    
                    cell.setup(with: data)
            }.disposed(by: disposeBag)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.commentsView.animateContainerView(direction: .down, duration: 0.01) { [weak self] in
            self?.commentsView.containerView.isHidden = false
            self?.commentsView.animateContainerView(direction: .up)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(commentsView)
        setupBinding()
        viewModel.fetchComments()
    }
    
    private func setupBinding() {
        
        self.commentsView.backgroundView.onTap(disposeBag: disposeBag) { [weak self] in
            self?.commentsView.animateContainerView(direction: .down, completion: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
        }
        
        self.commentsView.addCommentButton.onTap(disposeBag: disposeBag) { [weak self] in
            if let comment = self?.commentsView.commentTextField.text {
                if !comment.isEmpty {
                    self?.commentsView.endEditing(true)
                    self?.viewModel.addComment(comment: comment)
                    self?.commentsView.commentTextField.text = ""
                }
            }
        }
        
        self.commentsView.commentsTableView.rx.willDisplayCell
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (cell, indexPath) in
                if indexPath.row == (self?.viewModel.getCommentCount() ?? 0) - 1 {
                    if !(self?.viewModel.allCommentsFetched ?? true) {
                        self?.viewModel.fetchComments()
                    }
                }
             }).disposed(by: disposeBag)
        
    }
    
}
