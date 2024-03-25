//
//  MovieListViewModel.swift
//  TheMovieDB
//
//  Created by jossehblanco on 21/3/24.
//

import Combine
import Foundation

class MovieListViewModel: ObservableObject {
    // MARK: - Dependencies
    typealias Dependencies = HasMovieService

    // MARK: - Published Properties
    @Published var movies: [MovieTitleDomain] = .init()
    @Published var selectedListType: MovieListType = .nowPlaying
    @Published var isLoadingList: Bool = false
    @Published var isLoadingPage: Bool = false

    // MARK: - Properties
    private let dependencies: Dependencies
    private var cancellables = Set<AnyCancellable>()
    private var currentPage: Int = 1
    private var totalPages: Int = 1

    // MARK: - Initializer
    init(dependencies: Dependencies = HomeViewModelDependencies()) {
        self.dependencies = dependencies
        setupBindings()
    }

    // MARK: - Setup Bindings
    func setupBindings() {
        $selectedListType
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.fetchMovieList()
            }
            .store(in: &cancellables)
    }

    // MARK: - Fetch Movie List
    func fetchMovieList() {
        currentPage = 1
        let pageNumberString: String = String(currentPage)
        dependencies
            .movieService
            .getMoveList(for: selectedListType.apiCode, page: pageNumberString)
            .handleEvents(receiveRequest: { [weak self] _ in self?.isLoadingList = true })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoadingList = false
                guard case .failure(let error) = completion else { return }
                print("FATAL ERROR: \(error.localizedDescription)")
            } receiveValue: { [weak self] response in
                self?.handle(response: response)
                print("PAGES: \(response.totalPages)")

            }
            .store(in: &cancellables)
    }

    // MARK: - Fetch Next Page
    func fetchNextPage() {
        let pageNumberString: String = String(currentPage + 1)
        dependencies
            .movieService
            .getMoveList(for: selectedListType.apiCode, page: pageNumberString)
            .handleEvents(receiveRequest: { [weak self] _ in self?.isLoadingPage = true })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoadingPage = false
                guard case .failure(let error) = completion else { return }
                print("FATAL ERROR: \(error)")
            } receiveValue: { [weak self] response in
                self?.appendNextPage(response: response)
            }
            .store(in: &cancellables)
    }

    // MARK: - Get
    func getIsScrollableTrigger(for item: MovieTitleDomain) -> Bool {
        guard currentPage < totalPages else { return false }
        return item == movies.last
    }

    // MARK: - Handle Movie List Response
    private func handle(response: MovieListData) {
        totalPages = response.totalPages
        movies = response.results.map { .init(from: $0) }.filter { !movies.contains($0) }
    }

    // MARK: - Append Next Page
    private func appendNextPage(response: MovieListData) {
        totalPages = response.totalPages
        currentPage = response.page
        let newMovies: [MovieTitleDomain] = response.results.map { .init(from: $0) }.filter { !movies.contains($0) }
        movies.append(contentsOf: Set(newMovies))
    }
}

// MARK: - Dependency Struct
struct HomeViewModelDependencies: MovieListViewModel.Dependencies {
    var movieService: MovieServiceType {
        let dependencies = MovieServiceDependencies()
        return MovieService(dependencies: dependencies)
    }
}
