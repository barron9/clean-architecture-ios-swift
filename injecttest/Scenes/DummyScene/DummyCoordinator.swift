//
//  DummyCoordinator.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 2.11.2021.
//

import Foundation
import UIKit

class DummyCoordinator :NSObject, RootCoordinator {
    var navigationController: UINavigationController
    init(navigationController:UINavigationController){
        self.navigationController = navigationController
    }
 
    func start(){
        //instantiate viewcontroller
        //inject viewmodel into it
        //viewcontroller.coordinator = self
        let dvii = DummyViewController.instantiate()
        navigationController.delegate = self
        navigationController.pushViewController(dvii, animated: true)
        
    }
}
extension DummyCoordinator :UINavigationControllerDelegate {
    //fromviewcontroller
    //childedidfinish
    
}

