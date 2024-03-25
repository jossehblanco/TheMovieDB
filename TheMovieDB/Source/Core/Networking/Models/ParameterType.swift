//
//  ParameterType.swift
//  TheMovieDB
//
//  Created by jossehblanco on 24/3/24.
//

import Foundation

// MARK: - Parameter Type
enum ParameterType {
    case httpBody(parameter: Encodable)
    case urlParameters(queryItems: [String: String])
}
