//
//  String+Extensions.swift
//  eTurist
//
//  Created by Marko on 03.06.2021..
//

import Foundation

extension String {
    func checkBackspace() -> Bool {
        if let char = self.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                return true
            }
            return false
        }
        return false
    }
}
