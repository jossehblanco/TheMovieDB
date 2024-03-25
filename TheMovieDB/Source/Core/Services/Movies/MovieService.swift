//
//  MovieService.swift
//  TheMovieDB
//
//  Created by jossehblanco on 25/3/24.
//

import Combine
import Foundation

// MARK: - MovieServiceType
protocol MovieServiceType {
    func getMoveList(for type: String, page: String) -> AnyPublisher<MovieListData, APIError>
}

// MARK: - Movie Service
struct MovieService: MovieServiceType {
    // MARK: - Dependencies
    typealias Dependencies = HasNetworkRequester

    // MARK: - Properties
    private let dependencies: Dependencies

    // MARK: - Initializer
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Get Movie List
    func getMoveList(for type: String, page: String) -> AnyPublisher<MovieListData, APIError> {
        dependencies
            .networkRequester
            .execute(for: MovieTarget.movies(type: type, page: page))
    }
}

// MARK: - Dependency Struct
struct MovieServiceDependencies: MovieService.Dependencies {
    var networkRequester: NetworkRequesterType {
        let dependencies = NetworkRequesterDependencies()
        return NetworkRequester(dependencies: dependencies)
    }
}

// MARK: - Dependency Protocol
protocol HasMovieService {
    var movieService: MovieServiceType { get }
}
