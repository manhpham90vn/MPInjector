//
//  MPInjector+Errors.swift
//  MPInjector
//
//  Created by Manh Pham on 8/2/22.
//

import Foundation

public enum Errors: Error {
    case componentIsRegistered
    case canNotFindComponent
    case canNotResolveInstance
}
