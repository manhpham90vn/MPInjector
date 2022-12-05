//
//  MPInjector.swift
//  MPInjector
//
//  Created by Manh Pham on 8/1/22.
//

import Foundation

public protocol Registering {
    func registerService()
}

public protocol RegisteringMock {
    func registerServiceMock()
}

public class MPInjector {

    // instance singleton
    public static let shared = MPInjector()

    // variables
    private var registrations = [Int: ComponentProtocol]()
    private var instances = [Int: Any]()
    private var isInited = false
    private var isUnitTest: Bool {
        NSClassFromString("XCTest") != nil
    }

    // lock
    private let lock = NSRecursiveLock()

    // MARK: - PUBLIC METHOD

    /// function remove all registrations and instances
    public static func removeAll() {
        shared.registrations.removeAll()
        shared.instances.removeAll()
    }

    /// register service singleton
    public func registerSingleton<Service>(_ componentFactory: @escaping () -> Service) {
        try! registerThrowable(.init(componentFactory, lifeTime: .singleton))
    }

    /// register service factory
    public func registerFactory<Service>(_ componentFactory: @escaping () -> Service) {
        try! registerThrowable(.init(componentFactory, lifeTime: .factory))
    }

    /// register service mock
    public func registerMock<Service>(_ componentFactory: @escaping () -> Service) {
        defer { lock.unlock() }
        lock.lock()
        
        let identifier = Int(bitPattern: ObjectIdentifier(Service.self))
        registrations[identifier]?.componentFactoryMock = componentFactory
    }

    /// resolve instance
    public static func resolve<Service>() -> Service {
        return try! resolveThrowable()
    }

    // MARK: - PRIVATE METHOD

    private func checkInit() {
        if !isInited {
            if let self = self as? Registering {
                self.registerService()
            }
            if let self = self as? RegisteringMock {
                self.registerServiceMock()
            }
            isInited = true
        }
    }

    /// register service can throws
    private func registerThrowable<Service>(_ component: Component<Service>) throws {
        defer { lock.unlock() }
        lock.lock()

        if registrations[component.identifier] != nil {
            throw Errors.componentIsRegistered
        }

        registrations[component.identifier] = component
    }

    /// resolve instance can throws
    private static func resolveThrowable<Service>() throws -> Service {
        defer { shared.lock.unlock() }
        shared.lock.lock()

        shared.checkInit()

        let identifier = Int(bitPattern: ObjectIdentifier(Service.self))
        guard let component = shared.registrations[identifier] else {
            throw Errors.canNotFindComponent
        }

        // alway provide score factory for mock
        if let instance = component.componentFactoryMock?() as? Service,
           shared.isUnitTest {
            return instance
        }

        switch component.lifeTime {
        case .factory:
            if let instance = component.componentFactory() as? Service {
                return instance
            }
        case .singleton:
            if let instance = shared.instances[identifier] as? Service {
                return instance
            }
            if let instance = component.componentFactory() as? Service {
                shared.instances[identifier] = instance
                return instance
            }
        }

        throw Errors.canNotResolveInstance
    }
}
