//
//  TVDetails.swift
//  TheMovieDB
//
//  Created by Alejandro on 12/08/22.
//

import Foundation

struct TVDetails: Codable {
    let adult: Bool
    let backdrop_paht: String
    let created_by: [Author]
    let episode_run_time: [Int]
    let first_air_date: String
    let genres: [Genre]
    let homepage: String
    let id: Int
    let in_production: Bool
    let languages: [String]
    let last_air_date: String
    let last_episode_to_air: LastEpisode
    let name: String
    let next_episode_to_air: LastEpisode
    let networks: [Network]
    let number_of_episodes: Int
    let number_of_seasons: Int
    let origin_country: [String]
    let original_language: String
    let original_name: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let production_companies: [ProductionCompany]
    let production_countries: [ProductionCountry]
    let seasons: [Season]
    let spoken_languages: [SpokenLanguage]
    let status: String
    let tagline: String
    let type: String
    let vote_average: Double
    let vote_count: Int
}

struct SpokenLanguage: Codable {
    let english_name: String
    let iso_639_1: String
    let name: String
}

struct Season: Codable {
    let air_date: String
    let episode_count: Int
    let id: Int
    let name: String
    let overview: String
    let poster_path: String
    let season_number: Int
}

struct Network: Codable {
    let id: Int
    let name: String
    let logo_path: String?
    let origin_country: String
}

struct Author: Codable {
    let id: Int
    let credit_id: String
    let name: String
    let gender: Int
    let profile_path: String?
}

struct LastEpisode: Codable {
    let air_date: String
    let episode_number: Int
    let id: Int
    let name: String
    let overview: String
    let production_code: String
    let runtime: Int?
    let season_number: Int
    let show_id: Int
    let still_path: String?
    let vote_average: Double
    let vote_count: Int
}
