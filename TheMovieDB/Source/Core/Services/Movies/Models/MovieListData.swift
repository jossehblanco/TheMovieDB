//
//  MovieListData.swift
//  TheMovieDB
//
//  Created by jossehblanco on 25/3/24.
//

import Foundation

struct MovieListData: Codable {
    let listDates: MovieListDates?
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case listDates = "dates"
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieListDates: Codable {
    let maximum: String?
    let minimum: String?
}

struct Movie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIdList: [Int]
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let hasVideo: Bool?
    let voteAverage: Double?
    let voteCount: Double?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIdList = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case hasVideo = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
