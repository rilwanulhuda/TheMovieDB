//
//  MoviesDetailRequestModel.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 19/06/21.
//

import Foundation

struct MoviesDetailRequestModel {
    var movieId: Int
    
    func parameters() -> [String: Any]? {
        return [
            "api_key": APIConstant.apiKey,
            "language": "en-US",
            "append_to_response": "videos"
        ]
    }
}
