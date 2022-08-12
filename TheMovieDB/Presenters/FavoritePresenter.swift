//
//  FavoritePresenter.swift
//  TheMovieDB
//
//  Created by Alejandro on 11/08/22.
//

import Foundation
import UIKit

protocol FavoritePresenterDelegate {
    func showFavorites(movies: [MovieEntity])
}

typealias FavoriteDelegate = FavoritePresenterDelegate & UIViewController

class FavoritePresenter {
    
    weak var delegate: FavoriteDelegate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var movies = [MovieEntity]()
    
    public func setViewDelegate(delegate: FavoriteDelegate) {
        self.delegate = delegate
    }
    
    public func getFavorites() {
        do {
            movies = try context.fetch(MovieEntity.fetchRequest())
            self.delegate?.showFavorites(movies: movies)
        } catch {
            print("Error")
        }
    }
    
    public func createFavoriteMovie(movie: Movie) {
        let newMovie = MovieEntity(context: context)
        newMovie.title = movie.title
        newMovie.release_date = movie.release_date
        newMovie.poster_path = movie.poster_path
        newMovie.rating = "\(movie.vote_average)"
        newMovie.overview = movie.overview
        
        do {
            try context.save()
            getFavorites()
        } catch {
            print("Error saving core data.")
        }
    }
    
    public func createFavoriteShow(show: TVShow) {
        let newMovie = MovieEntity(context: context)
        newMovie.title = show.name
        newMovie.release_date = show.first_air_date
        newMovie.poster_path = show.poster_path
        newMovie.rating = "\(show.vote_average)"
        newMovie.overview = show.overview
        
        do {
            try context.save()
            getFavorites()
        } catch {
            print("Error saving core data.")
        }
    }
    
    public func deleteFavorite(movie: MovieEntity, reload: Bool) {
        context.delete(movie)
        do {
            try context.save()
            if reload {
                getFavorites()
            }
        } catch {
            print("Error")
        }
    }
    
}
