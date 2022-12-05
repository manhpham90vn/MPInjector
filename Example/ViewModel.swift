//
//  ViewModel.swift
//  Example
//
//  Created by Manh Pham on 05/12/2022.
//

import Foundation
import MPInjector

class ViewModel {
    
    @Inject var api: APIInterface
    @Inject var local: LocalInterface
    
    func request() -> Int {
        api.request()
    }
    
    func save() -> Int {
        local.save()
    }
    
}
