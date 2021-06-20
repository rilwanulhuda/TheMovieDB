//
//  MoviesResponseModel.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 18/06/21.
//

import Foundation

struct MoviesResponseModel: Codable {
    var page: Int?
    var totalPages: Int?
    var totalResults: Int?
    var results: [MovieResponseModel]?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results = "results"
    }
}

struct MovieResponseModel: Codable {
    var posterPath: String?
    var adult: Bool?
    var overview: String?
    var releaseDate: String?
    var genreIds: [Int]?
    var id: Int?
    var originalTitle: String?
    var originalLanguage: String?
    var title: String?
    var backdropPath: String?
    var popularity: Double?
    var voteCount: Int?
    var video: Bool?
    var voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id = "id"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title = "title"
        case backdropPath = "backdrop_path"
        case popularity = "popularity"
        case voteCount = "vote_count"
        case video = "video"
        case voteAverage = "vote_average"
    }
    
    /*
     "poster_path": "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
     "adult": false,
     "overview": "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
     "release_date": "2016-08-03",
     "genre_ids": [
         14,
         28,
         80
     ],
     "id": 297761,
     "original_title": "Suicide Squad",
     "original_language": "en",
     "title": "Suicide Squad",
     "backdrop_path": "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
     "popularity": 48.261451,
     "vote_count": 1466,
     "video": false,
     "vote_average": 5.91
     */
}
