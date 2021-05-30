//
//  Assembler+Extensions.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import Foundation
import Swinject

extension Assembler {
    static let sharedAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler([
            AppAssembly()
        ], container: container)
        return assembler
    }()
}
