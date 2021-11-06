//
//  ViewController.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 30.10.2021.
//

import UIKit

class DummyViewController: UIViewController, Base {
    static var storyboardName: String = "Main"
    
    var viewmodel: DummyViewModel?
    
    var dummyCache: CacheProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dummyCache?.pull(msg:"call from ViewController")
    }
    
}

