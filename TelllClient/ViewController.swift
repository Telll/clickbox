//
//  ViewController.swift
//  TelllClient
//
//  Created by Fernando Oliveira on 17/11/15.
//  Copyright © 2015 FCO. All rights reserved.
//

import UIKit
import SwiftCommandWS

class ViewController: UIViewController {
    @IBOutlet weak var lblConnected: UILabel!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var cws : CommandWS?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cws = CommandWS(url: NSURL(fileURLWithPath: "http://52.3.72.192:3000"))
        cws?.on("open") {
            self.lblConnected.text = "connected"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

