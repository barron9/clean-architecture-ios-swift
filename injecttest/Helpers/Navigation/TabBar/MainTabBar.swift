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
     
        let dummyController = createUINavigationControllerPer(title: "Sohbet", image: UIImage(named: "bubble")
        )
        let dummyCoordinator = DummyCoordinator(navigationController: dummyController)
        dummyCoordinator.start()
        
        
        let settingsConroller = createUINavigationControllerPer(title: "Ayarlar", image: UIImage(named: "gear")
        )
        let settingsCoordinator = SettingsCoordinator(navigationController: settingsConroller)
        settingsCoordinator.start()
        
        
        return [dummyCoordinator,settingsCoordinator]
        
    }
    
    class func createUINavigationControllerPer( title:String,image:UIImage?) -> UINavigationController{
        let nc = UINavigationController()
        nc.tabBarItem.title = title
        nc.tabBarItem.image = image
        return nc
    }
}
