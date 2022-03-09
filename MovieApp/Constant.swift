//
//  Constant.swift
//  MovieApp
//
//  Created by NISHANT RANJAN on 4/3/22.
//

import Foundation

//Result enum to show success or failure
enum Result<T> {
    case success(T)
    case failure(APPError)
}

//APPError enum which shows all possible errors
      enum APPError: Error {
          case networkError(Error)
          case dataNotFound
          case jsonParsingError(Error)
          case invalidStatusCode(Int)
      }

struct MovieConstant {
    static let baseUrl = "http://www.omdbapi.com/"
    static let apikey = "b831f50c"
    
    static let moveToDetailScreenSegue = "moveToDetailScreen"
    static let movieImage = "MovieImage"
}

public enum DownloadResult<T> {
    case sucess(T)
    case faliure(Error)
}


