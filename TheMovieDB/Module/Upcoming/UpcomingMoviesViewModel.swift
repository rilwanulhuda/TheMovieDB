//
//  UpcomingMoviesViewModel.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 17/06/21.
//

import Foundation

protocol UpcomingMoviesViewModelDelegate {
    func didSuccesGetUpcomingMovies()
    func didFailGetUpcomingMovies(message: String)
}

class UpcomingMoviesViewModel {
    let moviesProvider: MoviesProvider
    var delegate: UpcomingMoviesViewModelDelegate?
    var movies: [MoviesModel] = []
    var page: Int = 1
    var totalPages: Int = 0
    var totalResults: Int = 0
    var isLoadingMore: Bool = false

    init(moviesProvider: MoviesProvider) {
        self.moviesProvider = moviesProvider
    }

    func getUpcomingMovies() {
        moviesProvider.getUpcomingMovies(page: page, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let succesResponse):
                if let results = succesResponse.results {
                    self.page = succesResponse.page ?? 0
                    self.totalPages = succesResponse.totalPages ?? 0
                    self.totalResults = succesResponse.totalResults ?? 0

                    if self.isLoadingMore == false {
                        self.movies.removeAll()
                    }

                    for movieResponse in results {
                        let newMovie = MoviesModel(data: movieResponse)
                        self.movies.append(newMovie)
                    }

                    self.delegate?.didSuccesGetUpcomingMovies()
                } else {
                    print("No Movies Found")
                }
                self.isLoadingMore = false
            case .failure(let errorMsg):
                if self.isLoadingMore == true {
                    self.isLoadingMore = false
                    self.page -= 1
                }
                self.delegate?.didFailGetUpcomingMovies(message: errorMsg)
            }
        })
    }
}
