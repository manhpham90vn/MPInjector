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

    private var _wrappedValue: Component?

    public var wrappedValue: Component {
        mutating get {
            if let _wrappedValue = _wrappedValue {
                return _wrappedValue
            } else {
                let component: Component = MPInjector.resolve()
                _wrappedValue = component
                return component
            }
        }
        set(newValue) {
            _wrappedValue = newValue
        }
    }

    public init() {}
}
