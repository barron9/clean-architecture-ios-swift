//
//  ChatViewController.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 6.11.2021.
//

import UIKit

class ChatViewController: UIViewController,Base {
    static var storyboardName: String = "Main"
    
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "geri"
        self.tabBarController?.tabBar.isHidden = true
        
        EchoTest().echoTest()
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

    }
}
