//
//  HomeViewController.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import UIKit

class HomeViewController: BaseViewController {
    
    private let homeView = HomeView()
    var viewModel: HomeViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(homeView)
        setupBinding()
    }
    
    private func setupBinding() {
        homeView.tvTitle.onTap(disposeBag: disposeBag) { [weak self] in
            guard let self = self else { return }
            self.viewModel.getTestRoute(identifier: "zagreb")?.subscribe(onNext: { response in
                self.homeView.tvTitle.text = response.identifier
            }, onError: { error in
                self.homeView.tvTitle.text = error.localizedDescription
            }).disposed(by: self.disposeBag)
        }
    }
    
}
