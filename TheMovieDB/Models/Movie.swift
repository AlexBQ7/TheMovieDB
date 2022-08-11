//
//  Movie.swift
//  TheMovieDB
//
//  Created by Alejandro Barreto on 10/08/22.
//

import Foundation

struct MovieResult: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let original_language: String
    let original_title: String
    let popularity: Double
    let video: Bool
    let vote_count: Int
    let poster_path: String?
    let title: String
    let vote_average: Double
    let release_date: String
    let overview: String
}
