//
//  Cache.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 30.10.2021.
//

import Foundation

class Cache:CacheProtocol {
    init(network:NetworkingProtocol){
        print("inited: \(self)")
    }
    func push() {
        print("it is pushed")
    }
    
    func pull(msg:String) {
        print("it is pulled, \(msg)")
    }
    deinit{
        print("deinited: \(self)")
    }

}
