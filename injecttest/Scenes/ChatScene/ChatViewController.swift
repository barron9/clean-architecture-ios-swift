//
//  ChatViewController.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 6.11.2021.
//

import UIKit

class ChatViewController: UIViewController,Base {
    static var storyboardName: String = "Main"
    
    var client:EchoTest?
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "geri"
        self.tabBarController?.tabBar.isHidden = true
        
        client = EchoTest()

    }
    override func viewWillAppear(_ animated: Bool) {
       
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        client?.unload()
        client = nil
    }
}
