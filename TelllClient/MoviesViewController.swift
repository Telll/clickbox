//
//  MoviesViewController.swift
//  TelllClient
//
//  Created by Fernando Oliveira on 26/11/15.
//  Copyright © 2015 FCO. All rights reserved.
//

import UIKit
class MoviesViewController : TWSViewBase, UICollectionViewDelegate, UICollectionViewDataSource {
    let reuseIdentifier     = "movie"
    var movies  : [Movie]   = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tws.movies()

        self.tws.on("movies_ok") {(movies : [Movie]) in
            print("movies: \(movies)")
            self.movies = movies
            if let collection = self.collectionView {
                print("reloadData")
                collection.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    

    //1
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    //2
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    //3
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MovieCollectionViewCell
//        cell.backgroundColor = UIColor.blackColor()
        cell.populate(movies[indexPath.row])
        // Configure the cell
        return cell
    }
}