//
//  TWS.swift
//  TelllClient
//
//  Created by Fernando Oliveira on 24/11/15.
//  Copyright © 2015 FCO. All rights reserved.
//

import Foundation
import EventEmitter
import SwiftCommandWS
import SwiftyJSON

class TWS : EventEmitter {
    let cws         : CommandWS
    let url         : NSURL
    var auth_key    : String?
    var loggedIn    : Bool {
        get {
            return auth_key != nil
        }
    }
    
    init(url : NSURL = NSURL(string: "ws://52.3.72.192:3000/ws")!) {
        self.url = url
        cws = CommandWS(url: url)
        super.init()
        cws.on("open") {
            self.emit("connect")
        }
    }
    
    func login(user : String, passwd : String) {
        if !cws.isConnected {
            cws.connect()
        }
        
        let json : JSON = ["api_key": "1234", "user_name": user, "password": passwd, "model": "iPad"]
        cws.run("login", data: json) {cmd in
            if let auth_key = cmd.data!["auth_key"].string {
                self.auth_key = auth_key
                self.emit("login_ok", data: auth_key)
            } else {
                self.emit("login_error")
            }
        }
    }
    
    func logout() {
        if auth_key != nil {
            let json : JSON = ["api_key": "1234", "auth_key": auth_key!]
            cws.run("logout", data: json) {cmd in
                self.auth_key = nil
                self.emit("disconnect")
            }
        }
    }
    
    func disconnect() {
        cws.disconnect()
    }
}
