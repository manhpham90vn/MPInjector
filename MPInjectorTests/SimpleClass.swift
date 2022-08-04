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

protocol Fly {
    
}

class APIImp: API {
    
    @LazyInject var persion: Persion
    
    func call() {}
}
