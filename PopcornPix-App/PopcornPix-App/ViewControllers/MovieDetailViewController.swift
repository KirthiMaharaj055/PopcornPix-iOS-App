//
//  ViewController.swift
//  PopcornPix-App
//
//  Created by Kirthi Maharaj on 2024/08/26.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieMins: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieDetail: UITextView!
    @IBOutlet weak var movieGenres: UILabel!
    
    let movieProvider = MovieService()
    var movies: Movies?
    var movieDetails: MovieDetails?
    var movieID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getMovieDetails()
        
        // Do any additional setup after loading the view.
        
        //let exampleMovieId = 550
        
//        MovieService.shared.fetchMovieDetails{ result in
//            switch result {
//                case .success(let movieDetail):
//                print("Fetched movie detail: \(movieDetail)")
//                case .failure(let error):
//                    print("Failed to fetch movie detail: \(error)")
//            }
//        }
        
    }
    
    private func getMovieDetails(){
        movieProvider.movieId = movieID
//        movieProvider.fetchMovieDetails {[weak self] result in
//            switch result {
//            case .success(let movieDetails):
//                print(movieDetails)
//                self?.movieDetails = movieDetails
//                DispatchQueue.main.async {
//                    self?.configure(with: movieDetails)
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self?.showErrorAlert(message: error.localizedDescription)
//                }
//            }
//            
//        }
        
        movieProvider.fetchMovieDetail(for: movieID) { [weak self] result in
            switch result {
            case .success(let movieDetails):
                print(movieDetails)
                self?.movieDetails = movieDetails
                DispatchQueue.main.async {
                    self?.configure(with: movieDetails)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showErrorAlert(message: error.localizedDescription)
                }
            }
        }
    }

    func configure(with movie: MovieDetails) {
            self.movieDetails = movie
        movieTitle.text = " \(movie.original_title)"
        movieMins.text = "\(movie.runtime) mins |"
        movieReleaseDate.text = " \(movie.release_date)"
        movieDetail.text = "\(movie.overview)"
        
        
        // Fetch the image asynchronously
        if let posterPath = movie.poster_path, let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            // Use URLSession to download the image asynchronously
            let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
                guard let self = self, let data = data, error == nil else {
                    print("Failed to load image: \(String(describing: error))")
                    return
                }
                // Update the UI on the main thread
                DispatchQueue.main.async {
                    self.movieImage.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

