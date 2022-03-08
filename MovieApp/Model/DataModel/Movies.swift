//
//  Movies.swift
//  MovieApp
//
//  Created by NISHANT RANJAN on 4/3/22.
//

import Foundation

struct Movies: Decodable {
    var Search: [Search]?
    var totalResults: String?
    var Response: String?
}

struct Search: Decodable {
    var Title: String?
    var Year: String?
    var imdbID: String?
    var type: String?
    var Poster: String?
    
    enum CodingKeys: String, CodingKey {
        case Title = "Title"
        case Year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case Poster = "Poster"
    }
}

