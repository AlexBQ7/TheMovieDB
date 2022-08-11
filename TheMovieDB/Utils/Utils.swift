//
//  Utils.swift
//  TheMovieDB
//
//  Created by Alejandro Barreto on 10/08/22.
//

import Foundation
import UIKit

extension UIImageView {
    func loadUrlImage(url_string: String) {
        guard let url = URL(string: url_string) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
