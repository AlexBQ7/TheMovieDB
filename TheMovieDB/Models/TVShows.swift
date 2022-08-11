//
//  TVShows.swift
//  TheMovieDB
//
//  Created by Alejandro Barreto on 11/08/22.
//

import Foundation

struct TVShow: Codable {
    let poster_path: String?
    let popularity: Double
    let id: Int
    let backdrop_path: String?
    let vote_average: Double
    let overview: String
    let first_air_date: String
    let origin_country: [String]
    let genre_ids: [Int]
    let original_language: String
    let vote_count: Int
    let name: String
    let original_name: String
}

struct TVResult: Codable {
    let total_results: Int
    let total_pages: Int
    let page: Int
    let results: [TVShow]
}
