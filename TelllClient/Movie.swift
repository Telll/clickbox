//
//  Movie.swift
//  TelllClient
//
//  Created by Fernando Oliveira on 26/11/15.
//  Copyright © 2015 FCO. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
{
"category" : "NYI",
"author" : "NYI",
"player" : {
"_" : "NYI"
},
"id" : "0",
"image": "http://pugim.com.br/pudim.jpg"
"media" : {
"_" : "NYI"
},
"cript" : "NYI",
"title" : "Perl Hackers",
"description" : "Perl developers coding",
"url" : "http:\/\/www.perl.org\/"
},
*/


class Movie {
    var json        : JSON?
    var id          : Int?
    var category    : String?
    var author      : String?
    var title       : String?
    var description : String?
    var url         : NSURL
    var image       : NSURL?

    init(origJson : JSON) {
        json        = origJson
        id          = origJson["id"].int
        category    = origJson["category"].string
        author      = origJson["author"].string
        title       = origJson["title"].string
        description = origJson["description"].string
        
        if let sUrl = origJson["url"].string {
            url = NSURL(string: sUrl)!
        } else {
            url = NSURL()
        }
        
        if let sImage = origJson["image"].string {
            image = NSURL(string: sImage)
        }
    }
}


