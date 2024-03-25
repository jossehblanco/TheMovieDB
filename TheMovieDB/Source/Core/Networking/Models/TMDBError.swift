//
//  TMDBError.swift
//  TheMovieDB
//
//  Created by jossehblanco on 24/3/24.
//

import Foundation

struct TMDBError: Codable {
    let statusCode: Int
    let statusMessage: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success = "success"
    }
}
