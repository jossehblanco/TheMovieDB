//
//  NetworkProvider.swift
//  TheMovieDB
//
//  Created by jossehblanco on 22/3/24.
//

import Alamofire
import Combine
import Foundation

// MARK: - NetworkProviderType
protocol NetworkProviderType {
    func execute(for request: URLRequest) -> AnyPublisher<Data, APIError>
}

struct NetworkProvider: NetworkProviderType {
    // MARK: - Properties
    private let session: Session

    // MARK: - Execute
    func execute(for request: URLRequest) -> AnyPublisher<Data, APIError> {
        return Future { promise in
            session.request(request).responseData { response in
                switch response.result {
                case .success(let responseData):
                    promise(.success(responseData))
                case .failure(let error):
                    guard let errorData = response.data, let customError = try? JSONDecoder().decode(TMDBError.self, from: errorData) else {
                        promise(.failure(.underlying(error: error)))
                        return
                    }
                    promise(.failure(.tmdbError(error: customError)))
                }
            }
            .validate()
        }
        .eraseToAnyPublisher()
    }
}
