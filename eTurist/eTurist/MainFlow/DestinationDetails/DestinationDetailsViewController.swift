//
//  DestinationDetailsViewController.swift
//  eTurist
//
//  Created by Marko on 07.08.2021..
//

import UIKit

class DestinationDetailsViewController: BaseViewController {
    
    private let destinationDetailsView = DestinationDetailsView()
    var viewModel: DestinationDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(destinationDetailsView)
        self.destinationDetailsView.setup(with: viewModel.destination)
        self.setupBindings()
    }
    
    private func setupBindings() {
        self.destinationDetailsView.backButton.onTap(disposeBag: disposeBag) { [weak self] in
            self?.viewModel.exitDetailsScreen()
        }
    }
    
}
