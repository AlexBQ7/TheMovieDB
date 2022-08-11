//
//  FavoritePresenter.swift
//  TheMovieDB
//
//  Created by Alejandro on 11/08/22.
//

import Foundation
import UIKit

typealias FavoriteDelegate = HomePresenterDelegate & UIViewController

class FavoritePresenter {
    
    weak var delegate: FavoriteDelegate?
    
    
    public func setViewDelegate(delegate: FavoriteDelegate) {
        self.delegate = delegate
    }
    
}
