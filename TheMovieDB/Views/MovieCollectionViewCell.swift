//
//  MovieCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Alejandro Barreto on 10/08/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cover_image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var release_date: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var overview: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
