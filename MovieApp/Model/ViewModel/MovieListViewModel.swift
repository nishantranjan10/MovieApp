//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by NISHANT RANJAN on 4/3/22.
//

import Foundation

class MovieListViewModel {
    
    var moviesServices:MoviesServices
    
    init(moviesServices: MoviesServices) {
        self.moviesServices = moviesServices
    }
    
    func getMovieSearchListData<T: Decodable>(movieName : String,pageNumber : String,objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
        
        let urlString = "\(MovieConstant.baseUrl)?s=\(movieName)&apikey=\(MovieConstant.apikey)&page=\(pageNumber)"
        
        moviesServices.dataRequest(with: urlString, objectType: objectType.self) { (result: Result) in
            switch result {
            case .success(let object):
                completion(Result.success(object))
                
            case .failure(let error):
                print(error)
                completion(Result.failure(APPError.jsonParsingError(error)))
            }
        }
    }
}
