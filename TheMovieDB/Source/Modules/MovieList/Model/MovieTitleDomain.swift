//
//  MovieTitleDomain.swift
//  TheMovieDB
//
//  Created by jossehblanco on 21/3/24.
//

import Foundation

struct MovieTitleDomain: Identifiable, Equatable, Hashable {
    let id: Int
    let bannerUrl: String
    let name: String
    let releaseDate: String
    let rating: String
    let summary: String
}

extension MovieTitleDomain {
    static var test: MovieTitleDomain {
        .init(
            id: 1,
            bannerUrl: "https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg",
            name: "Fast and Furious",
            releaseDate: "2023-12-06",
            rating: "7.832",
            summary: "One man's campaign for vengeance takes on national stakes after he is revevaled to be a former operative of a powerful asdsadajsdaskdjasdsaj"
        )
    }

    init(from response: Movie) {
        self.init(
            id: response.id,
            bannerUrl: "https://image.tmdb.org/t/p/w500\(response.posterPath ?? "")",
            name: response.title ?? "N/A",
            releaseDate: response.releaseDate ?? "N/A",
            rating: String(response.voteAverage ?? 0.00),
            summary: response.overview ?? "N/A"
        )
    }
}
