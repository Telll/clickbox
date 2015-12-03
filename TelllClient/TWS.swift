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
    let cws             : CommandWS
    let url             : NSURL
    let api_key         : String    = "1234"
    var auth_key        : String?
    var movies_cache    : [Movie]?
    var loggedIn        : Bool {
        get {
            return auth_key != nil
        }
    }
    var jsonBase    : JSON {
        get {
            let base : JSON = ["api_key": api_key, "auth_key": auth_key!]
            return base
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
        
        let json : JSON = ["api_key": api_key, "user_name": user, "password": passwd, "model": "iPad"]
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
            let json : JSON = jsonBase
            cws.run("logout", data: json) {cmd in
                self.auth_key = nil
                self.emit("disconnect")
            }
        }
    }
    
    func disconnect() {
        cws.disconnect()
    }
    
    func movies() {
        if movies_cache != nil {
            emit("movies_ok", data: movies_cache!)
        } else {
            var json : JSON = jsonBase
            json["rows"].int = 999
            cws.run("movies", data: json) {cmd in
                if cmd["type"] != "ERROR" {
                    self.movies_cache = [Movie]()
                    for(_, movie) in cmd.data!["movies"] {
                        self.movies_cache!.append(Movie(origJson: movie))
                    }
                    self.emit("movies_ok", data: self.movies_cache!)
                } else {
                    self.emit("movies_error")
                }
            }
        }
    }
}
