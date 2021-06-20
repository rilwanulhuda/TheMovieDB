//
//  MoviesRequestModel.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 18/06/21.
//

import Foundation

struct MoviesRequestModel {
    var page: Int?

    func parameters() -> [String: Any]? {
        return [
            "api_key": APIConstant.apiKey,
            "page": page as Any,
            "language": "en-US"
        ]
    }
}
