//
//  MovieDetailsPresenter.swift
//  TheMovieDB
//
//  Created by Alejandro Barreto on 12/08/22.
//

import Foundation
import UIKit

protocol MovieDetailsPresenterDelegate {
    func showMovie(movie: [String:Any]?)
    func showTVShow(show: [String:Any]?)
    func sendMovie(movie: MovieEntity)
}

typealias MovieDetailsDelegate = MovieDetailsPresenterDelegate & UIViewController

class MovieDetailsPresenter {
    
    weak var delegate: MovieDetailsDelegate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func setViewDelegate(delegate: MovieDetailsDelegate) {
        self.delegate = delegate
    }
    
    func getMovie(id: Int) {
        APIProvider.shared.movieDetails(id: id) {
            response in
            self.delegate?.showMovie(movie: response)
        } failure: { error in
            print(error ?? "Error")
        }
    }
    
    func getShow(id: Int) {
        APIProvider.shared.tvshowDetails(id: id) {
            response in
            self.delegate?.showTVShow(show: response)
        } failure: { error in
            print(error ?? "Error")
        }
    }
    
    func addFavorite(poster: String, date: String, title: String, overview: String, rating: String) {
        let newMovie = MovieEntity(context: context)
        newMovie.title = title
        newMovie.release_date = date
        newMovie.poster_path = poster
        newMovie.rating = rating
        newMovie.overview = overview
        
        do {
            try context.save()
            self.delegate?.sendMovie(movie: newMovie)
        } catch {
            print("Error saving core data.")
        }
    }
    
    func deleteFavorite(fav: MovieEntity) {
        context.delete(fav)
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
}
