//
//  EchoTest.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 6.11.2021.
//

import Foundation
import Starscream

class EchoTest :NSObject, WebSocketDelegate{
    public var kclas:NSObject?
    
    let socket = WebSocket(request:URLRequest(url: URL(string: "ws://localhost:8765/")!) )
    
    var status : ChatStatus
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            print("websocket is connected: \(headers)")
            // self.socket.write(string: "... test ...")
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            break
        case .error(let error):
            break
        }}
    func unload(){
        kclas = nil
    }
    
    init(room:Int){
        self.status = .waiting
        super.init()
        self.kclas = self
        socket.delegate = self
        socket.request.timeoutInterval = 15
        socket.request.addValue(String(room), forHTTPHeaderField: "room")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            self.socket.connect()
        }
        
    }
    deinit{
        print("deinit")
    }
    
}

enum ChatStatus {
    case waiting,connected,disconnectd
}
