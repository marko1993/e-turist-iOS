//
//  UITextField+Extensions.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import UIKit
import RxSwift
import RxCocoa

extension UITextField {
    func onValueChanged(disposeBag: DisposeBag, completionHandler: @escaping (String?) -> Void) {
        self
            .rx
            .value
            .subscribe(onNext: { text in
                completionHandler(text)
            }).disposed(by: disposeBag)
    }
}
