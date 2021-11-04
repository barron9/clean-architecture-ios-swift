//
//  DummyAssembly.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 30.10.2021.
//

import Foundation
import Swinject

class DummyAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkingProtocol.self){
            r in
            return Networking()
        }
        container.register(CacheProtocol.self){r in
            let network = r.resolve(NetworkingProtocol.self)
            return Cache(network: network!)
        }.inObjectScope(.container)
    }
    
    
}
