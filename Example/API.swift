//
//  APIInterface.swift
//  Example
//
//  Created by Manh Pham on 05/12/2022.
//

import Foundation

protocol APIInterface {
    func request() -> Int
}

class APIImp: APIInterface {
    func request() -> Int {
        return 1
    }
}
