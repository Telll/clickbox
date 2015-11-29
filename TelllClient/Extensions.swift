//
//  UITextFieldExtension.swift
//  TelllClient
//
//  Created by Fernando Oliveira on 28/11/15.
//  Copyright © 2015 FCO. All rights reserved.
//

import UIKit

private var kAssociationKeyNextField: UInt8 = 0

extension UITextField {
    @IBOutlet var nextField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyNextField) as? UITextField
        }
        set(newField) {
            objc_setAssociatedObject(self, &kAssociationKeyNextField, newField, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension UIImageView {
    @nonobjc static var cache : [NSURL:UIImage] = [:]
    func downloadedFrom(url url:NSURL, contentMode mode: UIViewContentMode) {
        contentMode = mode
        if let cached = UIImageView.cache[url] {
            image = cached
            return
        }
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, _, error) -> Void in
            guard
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                UIImageView.cache[url] = image
                self.image = image
            }
        }).resume()
    }
}