//
//  AppMockInjector.swift
//  ExampleTests
//
//  Created by Manh Pham on 05/12/2022.
//

import Foundation
import MPInjector
@testable import Example

extension MPInjector: RegisteringMock {
    public func registerServiceMock() {
        registerMock { APIMock() as APIInterface }
    }
}
