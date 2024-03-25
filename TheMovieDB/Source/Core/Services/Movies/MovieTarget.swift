//
//  MovieTarget.swift
//  TheMovieDB
//
//  Created by jossehblanco on 25/3/24.
//

import Alamofire
import Foundation

enum MovieTarget: TargetType {
    case movies(type: String, page: String)

    var endpoint: String {
        switch self {
        case .movies(let type, _):
            return "/movie/\(type)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .movies:
            return .get
        }
    }

    var parameterType: ParameterType {
        switch self {
        case .movies(_, let page):
            let queryItems = ["page": page]
            return .urlParameters(queryItems: queryItems)
        }
    }
}
