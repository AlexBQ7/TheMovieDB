//
//  MovieDetailsViewController.swift
//  TheMovieDB
//
//  Created by Alejandro Barreto on 11/08/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterMovie: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var date_release: UILabel!
    @IBOutlet weak var total_rates: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var movieTitle: UILabel!
    
    var movie: Movie? = nil
    var show: TVShow? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let movie = movie {
            movieTitle.text = movie.title
            overview.text = movie.overview
            language.text = movie.original_language
            total_rates.text = "\(movie.vote_count)"
            date_release.text = movie.release_date
            rating.text = "\(movie.vote_average)"
            posterMovie.load(url: URL(string: "\(APIProvider.shared.images_url)\(movie.poster_path!)")!)
        } else if let show = show {
            movieTitle.text = show.name
            overview.text = show.overview
            language.text = show.original_language
            total_rates.text = "\(show.vote_count)"
            date_release.text = show.first_air_date
            rating.text = "\(show.vote_average)"
            posterMovie.load(url: URL(string: "\(APIProvider.shared.images_url)\(show.poster_path!)")!)
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        
    }
    
}
