//
//  ProfileViewController.swift
//  TheMovieDB
//
//  Created by Alejandro Barreto on 10/08/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var favoriteCollection: UICollectionView!
    private let presenter = FavoritePresenter()
    private var favorites = [MovieEntity]()
    private let widthScreen = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = "@\(UserDefaults.standard.string(forKey: "username") ?? "username")"
        favoriteCollection.delegate = self
        favoriteCollection.dataSource = self
        favoriteCollection.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        self.presenter.setViewDelegate(delegate: self)
        presenter.getFavorites()
    }

}

extension ProfileViewController: FavoritePresenterDelegate {
    func showFavorites(movies: [MovieEntity]) {
        favorites = movies
        
        DispatchQueue.main.async {
            self.favoriteCollection.reloadData()
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteCollection.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
        cell?.title.text = favorites[indexPath.row].title
        cell?.overview.text = favorites[indexPath.row].overview
        cell?.rating.text = favorites[indexPath.row].rating
        cell?.release_date.text = favorites[indexPath.row].release_date
        cell?.cover_image.load(url: URL(string: "\(APIProvider.shared.base_url)\(favorites[indexPath.row].poster_path!)")!)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (widthScreen - 60)/2, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
