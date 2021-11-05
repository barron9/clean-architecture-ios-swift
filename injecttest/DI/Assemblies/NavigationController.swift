//
//  NavigationController.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 2.11.2021.
//

import Foundation
import UIKit

class NavigationController{
    
    init(window:UIWindow?){
        guard let window = window else {
            return
        }

       let uit = UITabBarController()
        uit.setViewControllers(MainTabBar.build().map { $0.navigationController }, animated: true)
        window.rootViewController = uit
    }
}
