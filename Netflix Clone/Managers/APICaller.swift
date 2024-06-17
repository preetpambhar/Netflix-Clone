//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-06-15.
//

import Foundation

struct Constants {
    static let API_KEY = "6169ae1b75400a4afc05906feeeaf688"
    static let baseURL = "https://api.themoviedb.org/"
}

enum  APIError: Error{
    case failedToGetData
}

class APICaller{
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))

            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
