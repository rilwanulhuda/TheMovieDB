//
//  MoviesProvider.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 16/06/21.
//

import Foundation

class MoviesProvider {
    var networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func getNowPlaying(page: Int, completion: @escaping (FetchResult<MoviesResponseModel, String>) -> Void) {
        let model = MoviesRequestModel(page: page)
        let endpoint = Endpoint.nowPlaying(model: model)
        networkService.request(endpoint: endpoint, completion: completion)
    }

    func getTopRatedMovies(page: Int, completion: @escaping (FetchResult<MoviesResponseModel, String>) -> Void) {
        let model = MoviesRequestModel(page: page)
        let endpoint = Endpoint.topRated(model: model)
        networkService.request(endpoint: endpoint, completion: completion)
    }

    func getPopularMovies(page: Int, completion: @escaping (FetchResult<MoviesResponseModel, String>) -> Void) {
        let model = MoviesRequestModel(page: page)
        let endpoint = Endpoint.popular(model: model)
        networkService.request(endpoint: endpoint, completion: completion)
    }

    func getUpcomingMovies(page: Int, completion: @escaping (FetchResult<MoviesResponseModel, String>) -> Void) {
        let model = MoviesRequestModel(page: page)
        let endpoint = Endpoint.upcoming(model: model)
        networkService.request(endpoint: endpoint, completion: completion)
    }

    func getMovieDetail(movieId: Int, completion: @escaping (FetchResult<MoviesDetailResponseModel, String>) -> Void) {
        let model = MoviesDetailRequestModel(movieId: movieId)
        let endpoint = Endpoint.movieDetail(model: model)
        networkService.request(endpoint: endpoint, completion: completion)
    }
}
