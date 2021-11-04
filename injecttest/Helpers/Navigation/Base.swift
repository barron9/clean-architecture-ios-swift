//
//  Base.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 2.11.2021.
//

import UIKit

protocol Base{
    
    static var storyboardName: String { get }
    
    static func initialize()->Self
    
}

extension Base where Self : UIViewController  {
    
    static func initialize()->Self {
        
        let fullName = NSStringFromClass(self)
        
        let className = fullName.components(separatedBy: ".")[1]

        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: className) as! Self
   
    }
}
