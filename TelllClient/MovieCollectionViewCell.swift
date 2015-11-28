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
        let url = NSURL(string: "http://static.cineclick.com.br/sites/adm/uploads/banco_imagens/38/582x0_1391196580.jpg")
        image.downloadedFrom(url: url!, contentMode: .ScaleAspectFit)
    }
}
