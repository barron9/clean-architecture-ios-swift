//
//  TabBar.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 2.11.2021.
//

import Foundation
import UIKit

final class MainTabBar {
    class func build()->[RootCoordinator]{
     
        let dummyController = createUINavigationControllerPer(title: "Test Süreci", image: UIImage(named: "portfolio")
        )
        let dummyCoordinator = DummyCoordinator(navigationController: dummyController)
        dummyCoordinator.start()
        
        return [dummyCoordinator]
        
    }
    
    class func createUINavigationControllerPer( title:String,image:UIImage?) -> UINavigationController{
        let nc = UINavigationController()
        nc.tabBarItem.title = title
        nc.tabBarItem.image = image
        return nc
    }
}
