//
//  CodeValidationViewController.swift
//  eTurist
//
//  Created by Marko on 02.06.2021..
//

import UIKit

class CodeValidationViewController: BaseViewController {
    
    private let codeValidationView = CodeValidationView()
    var viewModel: CodeValidationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(codeValidationView)
        setupBinding()
    }
    
    private func setupBinding() {
        viewModel.errorRelay.asObservable().subscribe(onNext: { [weak self] error in
            if let error = error {
                self?.presentInfoDialog(message: error)
            }
        }).disposed(by: disposeBag)
        
        codeValidationView.confirmButton.onTap(disposeBag: disposeBag) { [weak self] in
            if let code = self?.codeValidationView.pinView.getCode() {
                self?.viewModel.varifyCode(code: code)
            } else {
                self?.presentInfoDialog(message: K.Strings.codeMustContainAllDigits)
            }
        }
        
    }
    
}
