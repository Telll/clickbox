//
//  MovieCollectionViewCell.swift
//  TelllClient
//
//  Created by Fernando Oliveira on 28/11/15.
//  Copyright © 2015 FCO. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    var movie               : Movie = Movie(origJson: [])
    
    func populate(movie : Movie) {
        title.text = movie.title
        if let url = movie.image {
            image.downloadedFrom(url: url, contentMode: .ScaleAspectFit)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        let img = UIImage(named: "noimage.jpg")
        image.image = img
    }
}
