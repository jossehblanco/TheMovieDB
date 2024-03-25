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

        headers
            .forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }

        return request
    }
}

// MARK: - App Values
extension TargetType {
    var baseUrl: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }

    var headers: [String: String] {
        return ["accept": "application/json", "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhODY5YTQyMGY5ZjNlYjc5NzlkNTQ1MTQ3YjQzMGQyYyIsInN1YiI6IjYwYzJiYTU5MWM2YWE3MDAyYWM3NGViNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.65Gpbvy0PJHJplUWGVDlNgITbT-OW0DGi1zkvbEB3AA"]
    }

    var sampleData: Data {
        Data()
    }
}
