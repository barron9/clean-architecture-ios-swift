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
    
    @IBOutlet var msgarea: UITextField!
    @IBOutlet var sendbtn: UIButton!
    
    var client:EchoTest?
    
    var data :[ChatMessage] = []
    override func viewDidLoad() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "geri"
        self.tabBarController?.tabBar.isHidden = true
        client = EchoTest()
        client?.socket.onEvent = onevent
        
        tablevie.delegate = self
        tablevie.dataSource = self
    
        sendbtn = UIButton()
    }
    
    @IBAction func sendbtn(_ sender: Any) {
        client?.socket.write(string: msgarea.text!)
        msgarea.text = ""
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    func onevent(s:WebSocketEvent?){
        switch s{
        case .text(let s):
            data.append(ChatMessage(message: s,from: "auto", datetime: String(Date().timeIntervalSince1970)))
            break
        case .none:
            break
        case .some(.connected(_)):
            break
        case .some(.disconnected(_, _)):
            break
        case .some(.binary(_)):
            break
        case .some(.pong(_)):
            break
        case .some(.ping(_)):
            break
        case .some(.error(_)):
            break
        case .some(.viabilityChanged(_)):
            break
        case .some(.reconnectSuggested(_)):
            break
        case .some(.cancelled):
            break
        }
        activity.isHidden = true
        print(s.debugDescription)
        rcv.text = " Received : \(s.debugDescription)"
        
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
