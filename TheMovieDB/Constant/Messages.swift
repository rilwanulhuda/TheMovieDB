//
//  Messages.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 17/06/21.
//

import Foundation

struct Messages {
    static let loading = "Please Wait.."
    static let noInternet = "No Internet Connection"
    static let unknownError = "Unknown Error"
    static let noMoviesFound = "No Movies Found"
    
    static let generalError: String = {
        if NetworkStatus.isInternetAvailable {
        return unknownError
        }
                
        return noInternet
    }()
}
