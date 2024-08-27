//
//  ViewController.swift
//  PopcornPix-App
//
//  Created by Kirthi Maharaj on 2024/08/26.
//

import UIKit

class MovieDetailViewController: UIViewController {

    let MovieProvider = MovieService()
    var movie: [Movies]?
    var movies: Movies?
    var movieDetails: MovieDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MovieService.shared.fetchAllMoviesApi { result in
            switch result {
                case .success(let movies):
                    print("Fetched movies: \(movies)")
                case .failure(let error):
                    print("Failed to fetch movies: \(error)")
            }
        }
        
        //let exampleMovieId = 550
        
        MovieService.shared.fetchMovieDetails{ result in
            switch result {
                case .success(let movieDetail):
                print("Fetched movie detail: \(movieDetail)")
                case .failure(let error):
                    print("Failed to fetch movie detail: \(error)")
            }
        }
        
    }

    func configure(with movie: MovieDetails) {
            self.movieDetails = movie
            // Update UI with movie details
        }
    
}

