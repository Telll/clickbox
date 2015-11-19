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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cws = CommandWS(url: NSURL(string: "ws://52.3.72.192:3000/ws")!)
        cws?.on("open") {
            self.lblConnected.text = "connected"
            self.btnConnect.enabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        cws?.disconnect()
    }

    @IBAction func login() {
        lblConnected.text = ""
        let json : JSON = ["api_key": "1234", "user_name": txtUser.text!, "password": txtPassword.text!, "model": "iPad"]
        cws?.run("login", data: json) {cmd in
            print("logged in!")
            if let auth_key = cmd.data!["auth_key"].string {
                self.lblConnected.text = "logged in: \(auth_key)"
            } else {
                self.lblConnected.text = "Wrong login"
            }
        }
    }

}

