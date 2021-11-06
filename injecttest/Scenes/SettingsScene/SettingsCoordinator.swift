//
//  SettingsCoordinator.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 6.11.2021.
//

import Foundation
import UIKit

class SettingsCoordinator :NSObject, RootCoordinator {
    var navigationController: UINavigationController
    init(navigationController:UINavigationController){
        self.navigationController = navigationController
    }
 
    func start(){
        //instantiate viewcontroller
        //inject viewmodel into it
        //viewcontroller.coordinator = self
        let dvii = SettingsViewController.instantiate()
        navigationController.delegate = self
        navigationController.pushViewController(dvii, animated: true)

    }
}
extension SettingsCoordinator :UINavigationControllerDelegate {
    //fromviewcontroller
    //childedidfinish
    
}

