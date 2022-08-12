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
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var companyCollection: UICollectionView!
    
    enum Fav {
        case favorite
        case no_favorite
        case none
    }
    
    enum MovieType {
        case movie
        case tvshow
    }
    
    var id: Int = 0
    let presenter = MovieDetailsPresenter()
    var fav = Fav.none
    var type = MovieType.movie
    var poster_url = ""
    var movieData: MovieEntity?
    var companies = [ProductionCompany]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.isNavigationBarHidden = true
        companyCollection.delegate = self
        companyCollection.dataSource = self
        companyCollection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "companyCell")
        presenter.setViewDelegate(delegate: self)
        switch type {
        case .movie:
            presenter.getMovie(id: id)
        case .tvshow:
            presenter.getShow(id: id)
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        switch fav {
        case .favorite:
            favoriteButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
            guard let movieData = movieData else { return }
            presenter.deleteFavorite(fav: movieData)
        case .no_favorite:
            favoriteButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            presenter.addFavorite(poster: poster_url, date: date_release.text!, title: movieTitle.text!, overview: overview.text!, rating: rating.text!)
        case .none:
            favoriteButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            presenter.addFavorite(poster: poster_url, date: date_release.text!, title: movieTitle.text!, overview: overview.text!, rating: rating.text!)
        }
    }
    
}

extension MovieDetailsViewController: MovieDetailsPresenterDelegate {
    func sendMovie(movie: MovieEntity) {
        movieData = movie
    }
    
    func showMovie(movie: [String:Any]?) {
        DispatchQueue.main.async {
            if let movie = movie {
                self.movieTitle.text = "\(movie["title"] ?? "Error")"
                self.rating.text = "\(movie["vote_average"] ?? 0)"
                self.overview.text = "\(movie["overview"] ?? "")"
                self.language.text = "\(movie["original_language"] ?? "EN")"
                self.total_rates.text = "\(movie["vote_count"] ?? 0)"
                self.date_release.text = "\(movie["release_date"] ?? "00-00-0000")"
                self.posterMovie.load(url: URL(string: "\(APIProvider.shared.images_url)\(movie["poster_path"]!)")!)
                self.poster_url = "\(movie["poster_path"]!)"
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: movie["production_companies"] ?? [:], options: [])
                    self.companies = try JSONDecoder().decode([ProductionCompany].self, from: data)
                    self.companyCollection.reloadData()
                    print(self.companies)
                } catch {
                    print("Error")
                }
            }
        }
    }
    
    func showTVShow(show: [String:Any]?) {
        DispatchQueue.main.async {
            if let movie = show {
                self.movieTitle.text = "\(movie["name"] ?? "Error")"
                self.rating.text = "\(movie["vote_average"] ?? 0)"
                self.overview.text = "\(movie["overview"] ?? "")"
                self.language.text = "\(movie["original_language"] ?? "EN")"
                self.total_rates.text = "\(movie["vote_count"] ?? 0)"
                self.date_release.text = "\(movie["first_air_date"] ?? "00-00-0000")"
                self.posterMovie.load(url: URL(string: "\(APIProvider.shared.images_url)\(movie["poster_path"]!)")!)
            }
        }
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = companyCollection.dequeueReusableCell(withReuseIdentifier: "companyCell", for: indexPath) as? CollectionViewCell
        cell?.company_image.load(url: URL(string: "\(APIProvider.shared.images_url)\(companies[indexPath.row].logo_path ?? "/hUzeosd33nzE5MCNsZxCGEKTXaQ.png")")!)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
