//
//  ViewController.swift
//  TelllClient
//
//  Created by Fernando Oliveira on 17/11/15.
//  Copyright © 2015 FCO. All rights reserved.
//

import UIKit
import SwiftCommandWS
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var lblConnected: UILabel!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnConnect: UIButton!
    var cws : CommandWS?
    let url = NSURL(string: "ws://52.3.72.192:3000/ws")!
    var retry = 0
    let maxTries = 5
    var loggedin = false
    var auth_key : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeCWS(false)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func initializeCWS(login : Bool) {
        cws = CommandWS(url: url)
        cws?.once("open") {
            self.lblConnected.text = "connected"
            self.btnConnect.enabled = true
            if login {
                self.login()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        cws?.disconnect()
    }

    @IBAction func login() {
        if loggedin {
            let json : JSON = ["api_key": "1234", "auth_key": auth_key!]
            cws!.run("logout", data: json) {cmd in
                self.loggedin = false
                self.btnConnect.setTitle("login", forState: .Normal)
                self.lblConnected.text = "connected"
            }
        } else {
            if !cws!.isConnected && retry < maxTries {
                cws = CommandWS(url: url)
                retry++
                return initializeCWS(true)
            }
            retry = 0
            lblConnected.text = ""
            let json : JSON = ["api_key": "1234", "user_name": txtUser.text!, "password": txtPassword.text!, "model": "iPad"]
            cws?.run("login", data: json) {cmd in
                print("logged in!")
                if let auth_key = cmd.data!["auth_key"].string {
                    self.loggedin = true
                    self.auth_key = auth_key
                    self.lblConnected.text = "logged in:\n\(auth_key)"
                    self.btnConnect.setTitle("logout", forState: .Normal)
                } else {
                    self.lblConnected.text = "Wrong login"
                }
            }
        }
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
}

