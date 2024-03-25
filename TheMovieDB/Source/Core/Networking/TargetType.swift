//
//  TargetType.swift
//  TheMovieDB
//
//  Created by jossehblanco on 22/3/24.
//

import Alamofire
import Foundation

// MARK: - TargetType
protocol TargetType {
    var baseUrl: URL { get }
    var headers: [String: String] { get }
    var sampleData: Data { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var parameterType: ParameterType { get }
}

// MARK: - URL Request Conversion
extension TargetType {
    var request: URLRequest {
        let requestUrl = baseUrl.appending(path: endpoint)

        var request = (try? URLRequest(url: requestUrl, method: method)) ?? URLRequest(url: requestUrl)

        switch parameterType {
        case .httpBody(let parameter):
            let bodyData = (try? JSONEncoder().encode(parameter)) ?? Data()
            request.httpBody = bodyData
        case .urlParameters(let queryItems):
            request.url = requestUrl.appending(queryItems: queryItems.map { .init(name: $0.key, value: $0.value)})
        }
        return request
    }
}
