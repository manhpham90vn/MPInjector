//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by Manh Pham on 05/12/2022.
//

import XCTest
import MPInjector
@testable import Example

final class ExampleTests: XCTestCase {
    
    let viewModel = ViewModel()
    
    override func setUp() {
        super.setUp()
    }
    
    func testExample() {
        XCTAssertEqual(viewModel.request(), 1)
    }
    
}
