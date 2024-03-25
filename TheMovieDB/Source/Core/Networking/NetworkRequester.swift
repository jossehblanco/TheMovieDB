//
//  NetworkRequester.swift
//  TheMovieDB
//
//  Created by jossehblanco on 22/3/24.
//

import Combine
import Foundation
import Alamofire

// MARK: - NetworkRequesterType
protocol NetworkRequesterType {
    func execute(for endpoint: TargetType) -> AnyPublisher<Data, APIError>
}

// MARK: - NetworkRequester
struct NetworkRequester: NetworkRequesterType {
    // MARK: - Dependencies
    typealias Dependencies = HasNetworkProvider

    // MARK: - Dependencies
    private let dependencies: Dependencies

    // MARK: - Initializer
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Execute Function
    func execute(for endpoint: TargetType) -> AnyPublisher<Data, APIError> {
        dependencies.networkProvider.execute(for: endpoint.request).eraseToAnyPublisher()
    }
}

// MARK: - Dependency Struct
struct NetworkRequesterDependencies: NetworkRequester.Dependencies {
    var networkProvider: NetworkProviderType {
        NetworkProvider(session: .default)
    }
}

// MARK: - Decodable Extension
extension NetworkRequesterType {
    func execute<T: Decodable>(for endpoint: TargetType, with decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, APIError> {
        execute(for: endpoint)
            .decode(type: T.self, decoder: decoder)
            .mapError { error -> APIError in
                guard let error = error as? APIError else {
                    return .underlying(error: error)
                }
                return error
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Dependency Protocol
protocol HasNetworkRequester {
    var networkRequester: NetworkRequesterType { get }
}
