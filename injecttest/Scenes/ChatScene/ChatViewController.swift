//
//  ChatViewController.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 6.11.2021.
//

import UIKit
import Starscream
import RxCocoa
import RxSwift

class ChatViewController: UIViewController,Base {
    
    static var storyboardName: String = "Main"
    
    static var roomNo: String = ""
    
    @IBOutlet var activity: UIActivityIndicatorView!
    @IBOutlet weak var tablevie: UITableView!
    
    @IBOutlet var msgarea: UITextField!
    @IBOutlet var sendbtn: UIButton!
    
    var client:EchoTest?
    
    var data :[ChatMessage] = []
    override func viewDidLoad() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "geri"
        self.tabBarController?.tabBar.isHidden = true
        
        client = EchoTest(room: ChatViewController.roomNo )
        client?.socket.onEvent = onevent
        
        tablevie.delegate = self
        tablevie.dataSource = self
        
        sendbtn = UIButton()
        
        setupBindings()
    }
    
    func setupBindings(){
        
        msgarea.rx.text.subscribe{
            e in
            print(e.event.element?.debugDescription)
        }
    }
    @IBAction func sendbtn(_ sender: Any) {
        guard let msg = msgarea.text , msgarea.text?.isEmpty != true else { return }
        client?.socket.write(string: msg)
        msgarea.text = ""
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let c = UIAlertController(title: "info", message: data[indexPath.row].toString() , preferredStyle: UIAlertController.Style.actionSheet)
        let a = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
        c.addAction(a)
        self.present(c, animated: true, completion: nil)
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
