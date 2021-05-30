//
//  UIImageView+Extensions.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import UIKit
import RxSwift

extension UIImageView {
    func onTap(disposeBag: DisposeBag, completionHandler: @escaping () -> Void) {
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        tap
            .rx
            .event
            .subscribe(onNext: { _ in
                completionHandler()
            }).disposed(by: disposeBag)
        self.addGestureRecognizer(tap)
    }
}

