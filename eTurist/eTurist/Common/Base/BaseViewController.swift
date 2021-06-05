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
        let alert = UIAlertController(title: K.Strings.appName, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: K.Strings.ok, style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentConfirmationDialog(title: String = K.Strings.appName,
                                   description: String = "",
                                   positiveButtonText: String = K.Strings.ok,
                                   completion: @escaping () -> Void) {
        
        let refreshAlert = UIAlertController(title: title, message: description, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: positiveButtonText, style: .default, handler: { (action: UIAlertAction!) in
            completion()
            refreshAlert.dismiss(animated: true, completion: nil)
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(refreshAlert, animated: true, completion: nil)
    }
    
}

