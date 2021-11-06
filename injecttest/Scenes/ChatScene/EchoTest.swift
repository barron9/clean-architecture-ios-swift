//
//  EchoTest.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 6.11.2021.
//

import Foundation
import Starscream

class EchoTest :NSObject, WebSocketDelegate{
    
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
    
    override init(){
        super.init()
        var request = URLRequest(url: URL(string: "ws://localhost:40510/")!)
        request.timeoutInterval = 1
        let socket = WebSocket(request:request )
        socket.delegate = self
        socket.connect()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            socket.write(string: "... test ...", completion: nil)
        }

    }
    func echoTest(){
        
    }
}

