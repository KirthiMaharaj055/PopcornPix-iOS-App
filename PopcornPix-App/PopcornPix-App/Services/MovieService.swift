//
//  MovieService.swift
//  PopcornPix-App
//
//  Created by Kirthi Maharaj on 2024/08/26.
//

import Foundation

class MovieService {
    
    static let shared = MovieService()
    private let baseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    var movieId: Int?
    
    func fetchAllMoviesApi(completion: @escaping (Result<[Movies], Error>) -> Void) {
        let urlString = "\(baseURL)discover/movie?api_key=\(apiKey)"
        let urlNew:String = urlString.replacingOccurrences(of: " ", with: "+").trimmingCharacters(in: .whitespacesAndNewlines)
        let url = URL(string: urlNew)!
        let sharedSession = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = sharedSession.dataTask(with: request) { data, _, error in
            guard let jsonData = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do{
                let BDecoder = JSONDecoder()
                let movieData = try BDecoder.decode(MovieResponse.self, from: jsonData)
                let movieList = movieData.results
                completion(.success(movieList))
                print(movieList)
            } catch let jsonError {
                completion(.failure(jsonError))
                print(jsonError)
            }
        }
        task.resume()
        
    }
    
    
    func fetchMovieDetail(for movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        let urlString = "\(baseURL)movie/\(movieId)?api_key=\(apiKey)"
        
        let urlNew:String = urlString.replacingOccurrences(of: " ", with: "+").trimmingCharacters(in: .whitespacesAndNewlines)
        let url = URL(string: urlNew)!
        let sharedSession = URLSession.shared
        let request = URLRequest(url: url)
        
        
//        guard let url = URL(string: urlString) else {
//            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
//            return
//        }
//
//        let sharedSession = URLSession.shared
//        let request = URLRequest(url: url)
        
//        let task = sharedSession.dataTask(with: request) { data, _, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let jsonData = data else {
//                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
//                return
//            }
//
//            do {
//                let movieDetail = try JSONDecoder().decode(MovieDetails.self, from: jsonData)
//                completion(.success(movieDetail))
//            } catch let jsonError {
//                completion(.failure(jsonError))
//            }
//        }
        
        let task = sharedSession.dataTask(with: request) { data, _, error in
            guard let jsonData = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do{
                let movieDetail = try JSONDecoder().decode(MovieDetails.self, from: jsonData)
                
                completion(.success(movieDetail))
                print(movieDetail)
            } catch let jsonError {
                completion(.failure(jsonError))
                print(jsonError)
            }
        }
        
        task.resume()
    }

    
}

