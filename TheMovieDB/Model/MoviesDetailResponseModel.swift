//
//  MoviesDetailResponseModel.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 19/06/21.
//

import Foundation

struct MoviesDetailResponseModel: Codable {
    var adult: Bool?
    var backdropPath: String?
    var budget: Int?
    var genres: [GenresResponseModel]?
    var homePage: String?
    var id: Int?
    var imdbId: String?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var productionCompanies: [ProductionCompaniesResponseModel]?
    var productionCountries: [ProductionCountriesResponseModel]?
    var releaseDate: String?
    var revenue: Int?
    var runTime: Int?
    var spokenLanguages: [SpokenLanguagesResponseModel]?
    var status: String?
    var tagLine: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var videos: VideosResponseModel?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case budget = "budget"
        case genres = "genres"
        case homePage = "homepage"
        case id = "id"
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue = "revenue"
        case runTime = "runtime"
        case spokenLanguages = "spoken_languages"
        case status = "status"
        case tagLine = "tagline"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case videos = "videos"
    }
}

struct GenresResponseModel: Codable {
    var id: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

struct ProductionCompaniesResponseModel: Codable {
    var name: String?
    var id: Int?
    var logoPath: String?
    var originCountry: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

struct ProductionCountriesResponseModel: Codable {
    var iso: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case iso = "iso_3166_1"
        case name = "name"
    }
}

struct SpokenLanguagesResponseModel: Codable {
    var iso: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case iso = "iso_639_1"
        case name = "name"
    }
}

struct VideosResponseModel: Codable {
    var results: [VideoResultsResponseModel]?

    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct VideoResultsResponseModel: Codable {
    var site: String?
    var id: String?
    var size: Int?
    var iso6391: String?
    var key: String?
    var iso31661: String?
    var name: String?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case site = "site"
        case id = "id"
        case size = "size"
        case iso6391 = "iso_639_1"
        case key = "key"
        case iso31661 = "iso_3166_1"
        case name = "name"
        case type = "type"
    }
}
