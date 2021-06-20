//
//  MovieDetailViewModel.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 19/06/21.
//

import Foundation

protocol MovieDetailViewModelDelegate {
    func didSuccessGetMovieDetail()
    func didFailGetMovieDetail(message: String)
}

class MovieDetailViewModel {
    let movieProvider: MoviesProvider
    var delegate: MovieDetailViewModelDelegate?
    var movieDetail: MovieDetailModel?
    var trailers: [TrailerModel] = []

    init(movieProvider: MoviesProvider) {
        self.movieProvider = movieProvider
    }

    func getMovieDetail(movieId: Int?) {
        guard let _movieId = movieId else {
            print("movieId: nil")
            return
        }

        movieProvider.getMovieDetail(movieId: _movieId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let successResponse):
                self.movieDetail = MovieDetailModel(data: successResponse)

                if let videoResults = successResponse.videos?.results {
                    for video in videoResults {
                        if let site = video.site, site.lowercased() == "youtube" {
                            let trailer = TrailerModel(data: video)
                            self.trailers.append(trailer)
                        }
                    }
                }

                self.delegate?.didSuccessGetMovieDetail()
            case .failure(let erroMsg):
                self.delegate?.didFailGetMovieDetail(message: erroMsg)
            }
        }
    }
}
