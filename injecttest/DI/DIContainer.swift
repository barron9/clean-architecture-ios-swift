//
//  Container.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 30.10.2021.
//

import Foundation
import Swinject
import ExternalProject

class DIContainer {
    public static let shared = DIContainer()
    private let container = Container()
    private var assembler : Assembler?
  
    init(){
        assembler = Assembler([
            DummyAssembly()
        ],container: self.container)
    }
    
    func resolve <T> () -> T  {
        guard let resolveResult = container.resolve(T.self) else {
            preconditionFailure()
        }
        return resolveResult
    }
}

 
