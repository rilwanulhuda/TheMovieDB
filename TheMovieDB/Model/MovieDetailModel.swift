//
//  MovieDetailModel.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 19/06/21.
//

import Foundation

struct MovieDetailModel {
    var backdropPathUrl: URL?
    var posterPathUrl: URL?
    var title: String?
    var releaseDate: String?
    var runtime: String?
    var tagline: String?
    var overview: String?
    var originalTitle: String?
    var budget: String?
    var revenue: String?
    var homePage: String?
    var genres: String?
    var productionCompanies: String?
    var productionCountries: String?
    
    init(data: MoviesDetailResponseModel) {
        self.title = data.title ?? "n/a"
        // self.releaseDate = data.releaseDate ?? "n/a"
        self.tagline = data.tagLine ?? "n/a"
        self.overview = data.overview ?? "n/a"
        self.originalTitle = data.originalTitle ?? "n/a"
        self.homePage = data.homePage ?? "n/a"
        self.runtime = "\(data.runTime ?? 0) minutes"
        
        // self.budget = data.budget ?? 0
        // self.revenue = data.revenue ?? 0
        
        // self.genres = data.genres
        // self.productionCompanies = data.productionCompanies
        // self.productionCountries = data.productionCountries
        
        let posterPath = data.posterPath ?? ""
        let posterPathUrlString = APIConstant.imgBaseUrl + "w185" + posterPath
        self.posterPathUrl = URL(string: posterPathUrlString)
        
        let backdropPath = data.backdropPath ?? ""
        let backdropPathUrlString = APIConstant.imgBaseUrl + "w300" + backdropPath
        self.backdropPathUrl = URL(string: backdropPathUrlString)
        
        if let releaseDate = data.releaseDate {
            self.releaseDate = releaseDate.toReleaseDate()
        } else {
            self.releaseDate = "Release on n/a"
        }
        
        if let budget = data.budget {
            self.budget = budget.toUSDollarFormat()
        } else {
            self.budget = "n/a"
        }
        
        if let revenue = data.revenue {
            self.revenue = revenue.toUSDollarFormat()
        } else {
            self.revenue = "n/a"
        }
        
        var genreNames: [String] = []
        if let genres = data.genres {
            for genre in genres {
                let name = genre.name ?? ""
                genreNames.append(name)
            }
        }
        
        self.genres = genreNames.joined(separator: ", ")
        
        var productionCompanyNames: [String] = []
        if let productionCompanies = data.productionCompanies {
            for productionCompany in productionCompanies {
                let name = productionCompany.name ?? ""
                productionCompanyNames.append(name)
            }
        }
        
        self.productionCompanies = productionCompanyNames.joined(separator: ", ")
        
        var productionCountryNames: [String] = []
        if let productionCountries = data.productionCountries {
            for productionCountry in productionCountries {
                let name = productionCountry.name ?? ""
                productionCountryNames.append(name)
            }
        }
        
        self.productionCountries = productionCountryNames.joined(separator: ", ")
    }
}

struct TrailerModel {
    var thumbnailUrl: URL?
    var videoUrl: URL?
    
    init(data: VideoResultsResponseModel) {
        let videoKey = data.key ?? ""
        
        let thumbnailUrlString = "https://img.youtube.com/vi/\(videoKey)/0.jpg"
        self.thumbnailUrl = URL(string: thumbnailUrlString)
        
        let videoUrlString = "https://www.youtube.com/watch?v=\(videoKey)"
        self.videoUrl = URL(string: videoUrlString)
        
        /*
         https://img.youtube.com/vi/P6QmSXqTv5I/0.jpg
         https://www.youtube.com/watch?v=P6QmSXqTv5I
         */
    }
}
