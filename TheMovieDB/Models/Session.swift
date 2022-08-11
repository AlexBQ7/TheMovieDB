//
//  Session.swift
//  TheMovieDB
//
//  Created by Alejandro on 11/08/22.
//

import Foundation

struct Session: Codable {
    let success: Bool?
    let session_id: String?
    let status_message: String?
    let status_code: Int?
}
