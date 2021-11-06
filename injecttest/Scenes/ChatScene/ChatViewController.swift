//
//  ChatViewController.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 6.11.2021.
//

import UIKit
import Starscream

class ChatViewController: UIViewController,Base {
    
    static var storyboardName: String = "Main"
    
    @IBOutlet var activity: UIActivityIndicatorView!
    @IBOutlet var rcv: UILabel!
    @IBOutlet weak var tablevie: UITableView!
    
    var client:EchoTest?
    
    var data = [
        ChatMessage(message: "msg1",from: "tester",datetime: "2021"),
        ChatMessage(message: "msg2",from: "tester",datetime: "2021"),
        ChatMessage(message: "msg3",from: "tester",datetime: "2021"),
        ChatMessage(message: "msg4",from: "tester",datetime: "2021"),
    ]
    override func viewDidLoad() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "geri"
        self.tabBarController?.tabBar.isHidden = true
        client = EchoTest()
        client?.socket.onEvent = onevent
        
        tablevie.delegate = self
        tablevie.dataSource = self
    
        
 
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    func onevent(s:WebSocketEvent?){
        activity.isHidden = true
        print(s.debugDescription)
        rcv.text = " Received : \(s.debugDescription)"
        data.append(ChatMessage(message: s.debugDescription,from: "auto", datetime: "nil"))
        tablevie.reloadData()
        if (data.count > 20){
            
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        client?.unload()
        client = nil
        data = []
    }
}

extension ChatViewController :UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

extension ChatViewController :UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as! TableCell
        
        cell.message?.text = data[indexPath.row].message
        cell.from?.text = data[indexPath.row].from
        cell.datetime = data[indexPath.row].datetime
        
        return cell
    }
    
    
}
