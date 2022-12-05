//
//  AppInjector.swift
//  Example
//
//  Created by Manh Pham on 05/12/2022.
//

import MPInjector

extension MPInjector: Registering {
    public func registerService() {
        registerSingleton { APIImp() as APIInterface }
        registerFactory { LocalStore() as LocalInterface }
    }
}
