//
//  APIImp.swift
//  Example
//
//  Created by Manh Pham on 05/12/2022.
//

import Foundation

protocol LocalInterface {
    func save() -> Int
}

class LocalStore: LocalInterface {
    func save() -> Int {
        return 1
    }
}
