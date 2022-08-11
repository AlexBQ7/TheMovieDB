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
        
    }

}

extension HomeViewController: HomePresenterDelegate {
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
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("Ancho: \((widthScreen - 60)/2)")
        return CGSize(width: (widthScreen - 60)/2, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollection.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
        cell?.title.text = movies[indexPath.row].title
        cell?.overview.text = movies[indexPath.row].overview
        cell?.rating.text = "\(movies[indexPath.row].vote_average)"
        cell?.release_date.text = movies[indexPath.row].release_date
        cell?.cover_image.loadUrlImage(url_string: movies[indexPath.row].poster_path!)
        
        return cell!
    }
}
