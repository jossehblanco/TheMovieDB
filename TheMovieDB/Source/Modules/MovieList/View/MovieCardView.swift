//
//  MovieCardView.swift
//  TheMovieDB
//
//  Created by jossehblanco on 21/3/24.
//

import SwiftUI

struct MovieCardView: View {
    // MARK: - Properties
    var movie: MovieTitleDomain

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            movieBanner

            movieTitle

            movieInformation

            movieSummary

            Spacer()
        }
        .padding(.bottom, 16)
        .background(Color(brandColor: .secondaryDark))
        .clipShape(RoundedRectangle(cornerRadius:16))
    }

    // MARK: - Movie Banner
    var movieBanner: some View {
        AsyncImage(url: .init(string: movie.bannerUrl)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Image(brandImage: .logo)
                .resizable()
                .scaledToFit()
        }
        .frame(height: 250)
        .clipped()
    }

    // MARK: - Movie Title
    var movieTitle: some View {
        HStack {
            Text(movie.name)
            Spacer()
        }
        .foregroundStyle(Color(brandColor: .tertiary))
        .font(.headline)
        .fontWeight(.bold)
        .padding(.horizontal, 8)
    }

    // MARK: - Movie Information
    var movieInformation: some View {
        HStack {
            Text(movie.releaseDate)
            Spacer()
            Label(movie.rating, systemImage: "star.fill")
        }
        .foregroundStyle(Color(brandColor: .tertiary))
        .font(.subheadline)
        .padding(.horizontal, 8)
    }

    // MARK: - Movie Summary
    var movieSummary: some View {
        Text(movie.summary)
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(4)
            .padding(.horizontal, 8)
            .foregroundStyle(.white)
            .font(.footnote)
    }
}

#Preview {
    let movie: MovieTitleDomain = .test
    return MovieCardView(movie: movie)
}
