//
//  NetworkResponse.swift
//  eTurist
//
//  Created by Marko on 01.06.2021..
//

import Foundation

struct NetworkResponse<T: Codable>: Codable {
    let status: Int
    let error: String?
    let data: T?
}
