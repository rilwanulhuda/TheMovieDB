//
//  Endpoint.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 16/06/21.
//

import Alamofire

enum Endpoint {
    case nowPlaying(model: MoviesRequestModel)
    case popular(model: MoviesRequestModel)
    case topRated(model: MoviesRequestModel)
    case upcoming(model: MoviesRequestModel)
    case movieDetail(model: MoviesDetailRequestModel)
}

extension Endpoint: IEndpoint {
    var url: String {
        return APIConstant.baseUrl + path
    }

    private var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .upcoming:
            return "/movie/upcoming"
        case .movieDetail(let model):
            return "/movie/\(model.movieId)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .nowPlaying,
             .popular,
             .topRated,
             .upcoming,
             .movieDetail:
            return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case .nowPlaying(let model):
            return model.parameters()
        case .popular(let model):
            return model.parameters()
        case .topRated(let model):
            return model.parameters()
        case .upcoming(let model):
            return model.parameters()
        case .movieDetail(let model):
            return model.parameters()
        }
    }

    var headers: HTTPHeaders? {
        return [
            "Content-Type": "application/json"
        ]
    }

    var encoding: ParameterEncoding {
        switch self {
        case .nowPlaying,
             .popular,
             .topRated,
             .upcoming,
             .movieDetail:
            return URLEncoding.queryString
        }
    }
}
