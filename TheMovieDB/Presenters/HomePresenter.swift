//
//  HomePresenter.swift
//  TheMovieDB
//
//  Created by Alejandro Barreto on 10/08/22.
//

import Foundation
import UIKit

protocol HomePresenterDelegate {
    func showMovies(movies: [Movie])
}

typealias HomeDelegate = HomePresenterDelegate & UIViewController

class HomePresenter {
    
    weak var delegate: HomeDelegate?
    
    public func setViewDelegate(delegate: HomeDelegate) {
        self.delegate = delegate
    }
    
    public func getPopular() {
        APIProvider.shared.getPopular {
            response in
            self.delegate?.showMovies(movies: response)
        } failure: { error in
            //show alert
            print(error ?? "Error")
        }
    }
    
    public func getTopRated() {
        APIProvider.shared.getTopRated {
            response in
            self.delegate?.showMovies(movies: response)
        } failure: { error in
            //show Alert
            print(error ?? "Error")
        }
    }
    
}
