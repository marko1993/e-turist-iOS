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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupView(_ view: UIView) {
        self.view.addSubview(view)
        view.fillSuperview()
    }
    
    func presentInfoDialog(message: String) {
        let alert = UIAlertController(title: "eTurist", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

