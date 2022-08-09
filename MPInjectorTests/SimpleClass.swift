//
//  SimpleClass.swift
//  MPInjectorTests
//
//  Created by Manh Pham on 8/4/22.
//

import Foundation
import MPInjector

protocol Persion {
    func work()
}

class Dev: Persion {
    
    @Inject var api: API
    
    func work() {}
}

protocol API {
    func call()
}

class APIImp: API {
    
    @LazyInject var persion: Persion
    
    func call() {}
}

protocol Fly {
    func flyable()
}

class Bird: Fly {
    func flyable() {}
}

extension MPInjector: Registering {
    public func registerService() {
        registerSingleton { Bird() as Fly }
    }
}
