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
    
    func configure(withInfo movies: Movies){
        self.movieTitle.text = movies.title
        
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\((movies.backdrop_path)!)")
        if let dataImage = try? Data(contentsOf: imageUrl!)  {
            self.movieImage.image = UIImage(data: dataImage)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
