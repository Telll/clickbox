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
    var auth_key    : String?
    var tws         : TWS {
        get {
            return (UIApplication.sharedApplication().delegate as! AppDelegate).tws
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        tws.once("connect") {
            self.lblConnected.text = "connected"
            self.btnConnect.enabled = true
        }
        tws.on("disconnect") {
            self.btnConnect.setTitle("login", forState: .Normal)
            self.lblConnected.text = "connected"
        }
        tws.on("login_ok") {(auth_key : String) in
            print("logged in!")
            self.auth_key = auth_key
            self.lblConnected.text = "logged in:\n\(auth_key)"
            self.btnConnect.setTitle("logout", forState: .Normal)
            self.tws.movies()
        }
        tws.on("login_error") {
            self.lblConnected.text = "Wrong login"
        }
        
        tws.on("movies") {movies in
            print(movies)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        tws.disconnect()
    }

    @IBAction func login() {
        if tws.loggedIn {
            tws.logout()
        } else {
            tws.login(txtUser.text!, passwd: txtPassword.text!)
        }
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
}

