//
//  RequestToken.swift
//  TheMovieDB
//
//  Created by Alejandro Barreto on 10/08/22.
//

import Foundation

struct TokenRequest: Codable {
    let success: Bool
    let expires_at: String
    let request_token: String
    let status_message: String?
}
