//
//  Photolink.swift
//  TelllClient
//
//  Created by Fernando Oliveira on 03/12/15.
//  Copyright © 2015 FCO. All rights reserved.
//

import Foundation
import SwiftyJSON

class Photolink {
    let origJson : JSON
    
    init(origJson : JSON) {
        self.origJson = origJson
        print("photolink: \(origJson)")
    }
}