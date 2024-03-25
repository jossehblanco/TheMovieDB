//
//  APIError .swift
//  TheMovieDB
//
//  Created by jossehblanco on 24/3/24.
//

import Foundation

enum APIError: LocalizedError {
    case tmdbError(error: TMDBError)
    case underlying(error: Error)

    var errorDescription: String? {
        switch self {
        case .tmdbError(let error):
            return "\(error.statusCode): \(error.statusMessage)"
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}
