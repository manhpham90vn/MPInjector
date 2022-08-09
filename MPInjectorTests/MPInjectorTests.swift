//
//  MPInjectorTests.swift
//  MPInjectorTests
//
//  Created by Manh Pham on 8/4/22.
//

import XCTest
@testable import MPInjector

class MPInjectorTests: XCTestCase {

    func testAutoRegister() {
        XCTContext.runActivity(named: "test auto register") { _ in
            let ex = expectation(description: "")
            let instance1: Fly = MPInjector.resolve()
            instance1.flyable()
            
            let instance2: Fly = MPInjector.resolve()
            instance2.flyable()
            
            XCTAssert(instance1 as AnyObject === instance2 as AnyObject)
            ex.fulfill()
            MPInjector.removeAll()
            wait(for: [ex], timeout: 1.0)
        }
    }
    
    func testRegisterSuccess() {
        XCTContext.runActivity(named: "test register instance") { _ in
            let ex = expectation(description: "")
            do {
                try MPInjector.shared.registerThrowable(.init({
                    Dev() as Persion
                }, lifeTime: .singleton))
                
                try MPInjector.shared.registerThrowable(.init({
                    APIImp() as API
                }, lifeTime: .factory))
                
                ex.fulfill()
            } catch {
                XCTFail()
            }
            MPInjector.removeAll()
            wait(for: [ex], timeout: 1.0)
        }
    }
    
    func testRegisterError() {
        XCTContext.runActivity(named: "test register instance error componentIsRegistered") { _ in
            let ex = expectation(description: "")
            do {
                try MPInjector.shared.registerThrowable(.init({
                    Dev() as Persion
                }, lifeTime: .singleton))
                
                try MPInjector.shared.registerThrowable(.init({
                    Dev() as Persion
                }, lifeTime: .singleton))
            } catch let error {
                let error = error as? Errors
                switch error {
                case .componentIsRegistered:
                    ex.fulfill()
                default:
                    XCTFail()
                }
            }
            MPInjector.removeAll()
            wait(for: [ex], timeout: 1.0)
        }
    }
    
    func testResolveError() {
        XCTContext.runActivity(named: "test register instance error canNotFindComponent") { _ in
            let ex = expectation(description: "")
            do {
                try MPInjector.shared.registerThrowable(.init({
                    Dev() as Persion
                }, lifeTime: .singleton))
                
                let instance: API = try MPInjector.resolveThrowable()
                instance.call()
            } catch let error {
                let error = error as? Errors
                switch error {
                case .canNotFindComponent:
                    ex.fulfill()
                default:
                    XCTFail()
                }
            }
            MPInjector.removeAll()
            wait(for: [ex], timeout: 1.0)
        }
    }
    
    func testResolveLifeTime1() {
        XCTContext.runActivity(named: "test can resolve intance lifetime factory") { _ in
            let ex = expectation(description: "")
            do {
                try MPInjector.shared.registerThrowable(.init({
                    Dev() as Persion
                }, lifeTime: .factory))
                
                try MPInjector.shared.registerThrowable(.init({
                    APIImp() as API
                }, lifeTime: .factory))
                
                let instance: Persion = try MPInjector.resolveThrowable()
                instance.work()
                
                let instance1: Persion = try MPInjector.resolveThrowable()
                instance1.work()
                ex.fulfill()
            } catch {
                XCTFail()
            }
            MPInjector.removeAll()
            wait(for: [ex], timeout: 1.0)
        }
    }
    
    func testResolveLifeTime1_1() {
        XCTContext.runActivity(named: "test can resolve intance lifetime singleton") { _ in
            let ex = expectation(description: "")
            do {
                try MPInjector.shared.registerThrowable(.init({
                    Dev() as Persion
                }, lifeTime: .singleton))
                
                try MPInjector.shared.registerThrowable(.init({
                    APIImp() as API
                }, lifeTime: .singleton))
                
                let instance: Persion = try MPInjector.resolveThrowable()
                instance.work()
                
                let instance1: Persion = try MPInjector.resolveThrowable()
                instance1.work()
                ex.fulfill()
            } catch {
                XCTFail()
            }
            MPInjector.removeAll()
            wait(for: [ex], timeout: 1.0)
        }
    }
    
    func testResolveLifeTime1_2() {
        XCTContext.runActivity(named: "test intance factory is diff") { _ in
            let ex = expectation(description: "")
            do {
                try MPInjector.shared.registerThrowable(.init({
                    Dev() as Persion
                }, lifeTime: .factory))
                
                try MPInjector.shared.registerThrowable(.init({
                    APIImp() as API
                }, lifeTime: .factory))
                
                let instance: Persion = try MPInjector.resolveThrowable()
                instance.work()
                
                let instance1: Persion = try MPInjector.resolveThrowable()
                instance1.work()
                
                XCTAssert(instance as AnyObject !== instance1 as AnyObject)
                ex.fulfill()
            } catch {
                XCTFail()
            }
            MPInjector.removeAll()
            wait(for: [ex], timeout: 1.0)
        }
    }
    
    func testResolveLifeTime1_3() {
        XCTContext.runActivity(named: "test intance singleton is same") { _ in
            let ex = expectation(description: "")
            do {
                try MPInjector.shared.registerThrowable(.init({
                    Dev() as Persion
                }, lifeTime: .singleton))
                
                try MPInjector.shared.registerThrowable(.init({
                    APIImp() as API
                }, lifeTime: .singleton))
                
                let instance: Persion = try MPInjector.resolveThrowable()
                instance.work()
                
                let instance1: Persion = try MPInjector.resolveThrowable()
                instance1.work()
                XCTAssert(instance as AnyObject === instance1 as AnyObject)
                ex.fulfill()
            } catch {
                XCTFail()
            }
            MPInjector.removeAll()
            wait(for: [ex], timeout: 1.0)
        }
    }
    
    func testResolveLifeTime1_4() {
        XCTContext.runActivity(named: "test intance singleton is same 2") { _ in
            let ex = expectation(description: "")
            MPInjector.shared.registerSingleton {
                Dev() as Persion
            }
            MPInjector.shared.registerSingleton {
                APIImp() as API
            }
            let instance: Persion = MPInjector.resolve()
            instance.work()
            let instance1: Persion = MPInjector.resolve()
            instance1.work()
            
            XCTAssert(instance as AnyObject === instance1 as AnyObject)
            ex.fulfill()
            
            MPInjector.removeAll()
            wait(for: [ex], timeout: 1.0)
        }
    }
    
    func testResolveLifeTime1_5() {
        XCTContext.runActivity(named: "test intance factory is diff") { _ in
            let ex = expectation(description: "")
            MPInjector.shared.registerFactory {
                Dev() as Persion
            }
            MPInjector.shared.registerFactory {
                APIImp() as API
            }
            let instance: Persion = MPInjector.resolve()
            instance.work()
            let instance1: Persion = MPInjector.resolve()
            instance1.work()
            
            XCTAssert(instance as AnyObject !== instance1 as AnyObject)
            ex.fulfill()
            
            MPInjector.removeAll()
            wait(for: [ex], timeout: 1.0)
        }
    }
}
