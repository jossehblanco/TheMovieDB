//
//  HomeView.swift
//  TheMovieDB
//
//  Created by jossehblanco on 21/3/24.
//

import SwiftUI

struct MovieListView: View {
    // MARK: - Properties
    @StateObject var viewModel: MovieListViewModel
    @State var selectedCategory: Int = 0
    private let columns: [GridItem] = [.init(.flexible()), .init(.flexible())]

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                segmentedControl
                if viewModel.isLoadingList {
                    Spacer()
                    ProgressView()
                        .tint(.white)
                    Spacer()
                } else {
                    movies
                }
            }
            .padding()
            .preferredColorScheme(.dark)
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(brandColor: .primary), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    // MARK: - Movie Show Grid
    private var movies: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.movies) { movie in
                    if viewModel.getIsScrollableTrigger(for: movie) {
                        MovieCardView(movie: movie)
                            .id(movie.id)
                            .onAppear {
                                viewModel.fetchNextPage()
                            }
                    } else {
                        MovieCardView(movie: movie)
                            .id(movie.id)
                    }
                }
            }

            if viewModel.isLoadingPage {
                ProgressView()
            }
        }
    }

    // MARK: - Background Color
    private var background: some View {
        Color(.black)
            .ignoresSafeArea(.all)
    }

    // MARK: - Segmented Control
    private var segmentedControl: some View {
        Picker("", selection: $viewModel.selectedListType) {
            ForEach(MovieListType.allCases) { listType in
                Text(listType.rawValue)
                    .tag(listType)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    MovieListView(viewModel: .init())
}
