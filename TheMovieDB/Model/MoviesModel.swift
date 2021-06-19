//
//  MoviesModel.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 18/06/21.
//

import Foundation

struct MoviesModel {
    var title: String?
    var body: String?
    var date: String?
    var imgUrlString: String?
    
    init(data: MoviesDetailResponseModel) {
        self.title = data.title ?? "n/a"
        self.body = data.overview ?? "n/a"
        self.date = data.releaseDate ?? "n/a"
        
        let posterPath = data.posterPath ?? "n/a"
        self.imgUrlString = APIConstant.imgBaseUrl + "w185" + posterPath
    }
}
