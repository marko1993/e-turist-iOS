//
//  HistoryViewController.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit

class HistoryViewController: BaseViewController {
    
    private let historyView = HistoryView()
    var viewModel: HistoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(historyView)
    }
    
}
