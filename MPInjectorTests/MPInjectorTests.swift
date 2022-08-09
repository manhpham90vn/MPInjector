//
//  MPInjectorTests.swift
//  MPInjectorTests
//
//  Created by Manh Pham on 8/4/22.
//

import XCTest
@testable import MPInjector

class MPInjectorTests: XCTestCase {

    override class func setUp() {
        super.setUp()
    }
    
    func testAutoRegister() {
        XCTContext.runActivity(named: "test resolve auto register") { _ in
            let ex = expectation(description: "")
            let instance1: Fly = MPInjector.resolve()
            instance1.flyable()
            let instance2: Fly = MPInjector.resolve()
            instance2.flyable()
            ex.fulfill()
            MPInjector.removeAll()
            wait(for: [ex], timeout: 1.0)
        }
    }
    
    func testRegisterSuccess() {
        XCTContext.runActivity(named: "test register instance") { _ in
            let ex = expectation(description: "")
            MPInjector.shared.registerSingleton { Dev() as Persion }
            MPInjector.shared.registerFactory { APIImp() as API }
            let instance1: Persion = MPInjector.resolve()
            let instance2: Persion = MPInjector.resolve()
            let instance3: API = MPInjector.resolve()
            let instance4: API = MPInjector.resolve()
            XCTAssert(instance1 as AnyObject === instance2 as AnyObject)
            XCTAssert(instance3 as AnyObject !== instance4 as AnyObject)
            ex.fulfill()
            MPInjector.removeAll()
            wait(for: [ex], timeout: 1.0)
        }
    }
}
