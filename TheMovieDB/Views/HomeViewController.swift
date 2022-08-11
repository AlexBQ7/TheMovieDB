//
//  HomeViewController.swift
//  TheMovieDB
//
//  Created by Alejandro Barreto on 10/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let presenter = HomePresenter()
    private var movies = [Movie]()
    private var shows = [TVShow]()
    private let widthScreen = UIScreen.main.bounds.width
    @IBOutlet weak var categories: UISegmentedControl!
    @IBOutlet weak var moviesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TV Shows"
        self.navigationController?.navigationBar.backgroundColor = .gray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(menu))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
        moviesCollection.delegate = self
        moviesCollection.dataSource = self
        moviesCollection.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        presenter.setViewDelegate(delegate: self)
        presenter.getPopular()
    }
    
    @objc func menu() {
        let alert = UIAlertController(title: "What do you want to do?", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "View profile", style: .default, handler: { (handler) in
            self.performSegue(withIdentifier: "profileSegue", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (handler) in
            self.presenter.logout()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func selectContent(_ sender: Any) {
        switch (categories.selectedSegmentIndex) {
        case 0:
            presenter.getPopular()
        case 1:
            presenter.getTopRated()
        case 2:
            presenter.onTV()
            break
        case 3:
            presenter.getAiringToday()
            break
        default:
            break
        }
    }
    
}

extension HomeViewController: HomePresenterDelegate {
    func closeSession() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func showTVShows(shows: [TVShow]) {
        self.shows = shows
        
        DispatchQueue.main.async {
            self.moviesCollection.reloadData()
        }
    }
    
    func showMovies(movies: [Movie]) {
        self.movies = movies
        
        DispatchQueue.main.async {
            self.moviesCollection.reloadData()
        }
        print("Populares: \(movies)")
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch categories.selectedSegmentIndex {
        case 0...1:
            return movies.count
        case 2...3:
            return shows.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (widthScreen - 60)/2, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollection.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
        switch categories.selectedSegmentIndex {
        case 0...1:
            cell?.title.text = movies[indexPath.row].title
            cell?.overview.text = movies[indexPath.row].overview
            cell?.rating.text = "\(movies[indexPath.row].vote_average)"
            cell?.release_date.text = movies[indexPath.row].release_date
            cell?.cover_image.load(url: URL(string: "\(APIProvider.shared.base_url)\(movies[indexPath.row].poster_path!)")!)
            print("Movie: \(APIProvider.shared.images_url)\(movies[indexPath.row].poster_path!)")
        case 2...3:
            cell?.title.text = shows[indexPath.row].name
            cell?.overview.text = shows[indexPath.row].overview
            cell?.rating.text = "\(shows[indexPath.row].vote_average)"
            cell?.release_date.text = shows[indexPath.row].first_air_date
            cell?.cover_image.load(url: URL(string: "\(APIProvider.shared.images_url)\(shows[indexPath.row].poster_path!)")!)
        default:
            break
        }
        
        return cell!
    }
}
