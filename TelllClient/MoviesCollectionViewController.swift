//
//  MoviesCollectionViewController.swift
//  TelllClient
//
//  Created by Fernando Oliveira on 27/11/15.
//  Copyright © 2015 FCO. All rights reserved.
//

import UIKit

class MoviesCollectionViewController : UICollectionViewController {
    let reuseIdentifier     = "movie"
    var movies  : [Movie]   = []
    var tws     : TWS? {
        get {
            if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                return delegate.tws
            } else {
                return nil
            }
        }
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tws.movies()
//        
//        self.tws.on("movies") {(movies : [Movie]) in
//            print(movies)
////            self.movies = movies
////            if let collection = self.collectionView {
////                collection.reloadData()
////            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

    }
}

extension MoviesCollectionViewController {
    
    //1
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    //3
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        // Configure the cell
        return cell
    }
}