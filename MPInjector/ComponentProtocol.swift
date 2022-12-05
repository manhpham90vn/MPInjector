//
//  ComponentProtocol.swift
//  MPInjector
//
//  Created by Manh Pham on 8/1/22.
//

import Foundation

public typealias ComponentFactory = () -> Any

public protocol ComponentProtocol {
    var lifeTime: Lifetime { get }
    var identifier: Int { get }
    var componentFactory: ComponentFactory { get }
    var componentFactoryMock: ComponentFactory? { get set }
}
