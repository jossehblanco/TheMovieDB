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
    let provider: NetworkProviderType

    // MARK: - Execute Function
    func execute(for endpoint: TargetType) -> AnyPublisher<Data, APIError> {
        return provider.execute(for: endpoint.request).eraseToAnyPublisher()
    }
}

// MARK: - Decodable Extension
extension NetworkRequester {
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
