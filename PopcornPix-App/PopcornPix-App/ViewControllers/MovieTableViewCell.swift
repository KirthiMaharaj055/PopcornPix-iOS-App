//
//  MovieTableViewCell.swift
//  PopcornPix-App
//
//  Created by Kirthi Maharaj on 2024/08/27.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    func configure(withInfo movies: Movies) {
        self.movieTitle.text = movies.title
        
        if let backdropPath = movies.backdrop_path, let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)") {
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


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
