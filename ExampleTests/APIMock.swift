//
//  APIMock.swift
//  ExampleTests
//
//  Created by Manh Pham on 05/12/2022.
//

import Foundation
@testable import Example

class APIMock: APIInterface {
    func request() -> Int {
        return 2
    }
}
