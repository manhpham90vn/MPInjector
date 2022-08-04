//
//  MPInjector.swift
//  MPInjector
//
//  Created by Manh Pham on 8/1/22.
//

import Foundation

public class MPInjector {

    // variables
    private static var registrations = [Int: ComponentProtocol]()
    private static var instances = [Int: Any]()
    private static let lock = NSRecursiveLock()
    
    /// function remove all registrations and instances
    public static func removeAll() {
        registrations.removeAll()
        instances.removeAll()
    }
    
    /// register service can throws
    public static func registerThrowable<Service>(_ component: Component<Service>) throws {
        defer { lock.unlock() }
        lock.lock()
        if registrations[component.identifier] != nil {
            throw Errors.componentIsRegistered
        }
        registrations[component.identifier] = component
    }
        
    /// register service singleton
    public static func registerSingleton<Service>(_ componentFactory: @escaping () -> Service) {
        try! registerThrowable(.init(componentFactory, lifeTime: .singleton))
    }
    
    /// register service factory
    public static func registerFactory<Service>(_ componentFactory: @escaping () -> Service) {
        try! registerThrowable(.init(componentFactory, lifeTime: .factory))
    }
    
    /// resolve instance can throws
    public static func resolveThrowable<Service>() throws -> Service {
        defer { lock.unlock() }
        lock.lock()

        let identifier = Int(bitPattern: ObjectIdentifier(Service.self))
        guard let component = registrations[identifier] else {
            throw Errors.canNotFindComponent
        }
        
        switch component.lifeTime {
        case .factory:
            if let instance = component.componentFactory() as? Service {
                return instance
            }
        case .singleton:
            if let instance = instances[identifier] as? Service {
                return instance
            }
            if let instance = component.componentFactory() as? Service {
                instances[identifier] = instance
                return instance
            }
        }
        throw Errors.canNotResolveInstance
    }
    
    /// resole instance
    public static func resolve<Service>() -> Service {
        return try! resolveThrowable()
    }
}
