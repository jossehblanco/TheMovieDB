//
//  MovieListType.swift
//  TheMovieDB
//
//  Created by jossehblanco on 25/3/24.
//

import Foundation

enum MovieListType: String, Identifiable, CaseIterable {
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"

    var apiCode: String {
        switch self {
        case .nowPlaying:
            return "now_playing"
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upcoming:
            return "upcoming"
        }
    }
    var id: String {
        self.apiCode
    }
}
