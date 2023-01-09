//
//  MPInjector+PropertyWrappers.swift
//  MPInjector
//
//  Created by Manh Pham on 8/1/22.
//

import Foundation

@propertyWrapper
public struct Inject<Component> {
    public var wrappedValue: Component

    public init() {
        self.wrappedValue = MPInjector.resolve()
    }
}

@propertyWrapper
public struct LazyInject<Component> {
    public var wrappedValue: Component {
        get {
            let component: Component = MPInjector.resolve()
            return component
        }
    }

    public init() {}
}
