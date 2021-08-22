//
//  DestinationDetailsViewController.swift
//  eTurist
//
//  Created by Marko on 07.08.2021..
//

import UIKit

class DestinationDetailsViewController: NavigationViewController {
    
    private let destinationDetailsView = DestinationDetailsView()
    var viewModel: DestinationDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation(title: viewModel.destination.name)
        setupView(destinationDetailsView)
        self.destinationDetailsView.setup(with: viewModel.destination)
        self.setupBindings()
    }
    
    private func setupBindings() {
        self.destinationDetailsView.commentButton.onTap(disposeBag: disposeBag) { [weak self] in
            self?.viewModel.showCommentsScreen()
        }
    }
    
    override func backPressed(sender: AnyObject) {
        self.viewModel.exitDetailsScreen()
    }
    
}
