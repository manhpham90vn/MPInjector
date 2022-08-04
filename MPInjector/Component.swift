//
//  Component.swift
//  MPInjector
//
//  Created by Manh Pham on 8/1/22.
//

import Foundation

public class Component<Service>: ComponentProtocol {
    public let lifeTime: Lifetime
    public let identifier: Int
    public let componentFactory: ComponentFactory

    public init(_ factory: @escaping () -> Service, lifeTime: Lifetime) {
        self.lifeTime = lifeTime
        self.identifier = Int(bitPattern: ObjectIdentifier(Service.self))
        self.componentFactory = { factory() }
    }
}
