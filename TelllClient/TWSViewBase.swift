//
//  TWSViewInterface.swift
//  TelllClient
//
//  Created by Fernando Oliveira on 26/11/15.
//  Copyright © 2015 FCO. All rights reserved.
//

import UIKit

class TWSViewBase : UIViewController {

    var tws : TWS {
        get {
            return (UIApplication.sharedApplication().delegate as! AppDelegate).tws
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        tws.disconnect()
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showMovies() {
        let moviesViewController : MoviesViewController = MoviesViewController()
        
        self.presentViewController(moviesViewController, animated: true, completion: nil)
    }
    
    func showLogin() {
        let loginControllerView : LoginViewController = LoginViewController()
        
        self.presentViewController(loginControllerView, animated: true, completion: nil)
    }
}