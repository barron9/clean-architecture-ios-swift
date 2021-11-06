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
    
    let socket = WebSocket(request:URLRequest(url: URL(string: "ws://35.157.202.250:8765/")!) )
    
    var status : ChatStatus
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                print("websocket is connected: \(headers)")
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
    
    override init(){
        self.status = .waiting
        super.init()
        self.kclas = self
        socket.delegate = self
        socket.request.timeoutInterval = 15
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            self.socket.connect()
            self.socket.write(string: "... test ...")
        }

    }
    deinit{
        print("deinit")
    }
    
}

enum ChatStatus {
    case waiting,connected,disconnectd
}
