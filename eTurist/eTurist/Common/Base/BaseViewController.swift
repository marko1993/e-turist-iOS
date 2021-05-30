//
//  BaseViewController.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupView(_ view: UIView) {
        self.view.addSubview(view)
        view.fillSuperview()
    }
    
}

