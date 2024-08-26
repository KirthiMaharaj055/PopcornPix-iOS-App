//
//  Movie.swift
//  PopcornPix-App
//
//  Created by Kirthi Maharaj on 2024/08/26.
//

import Foundation

struct Movies: Codable {
    let movieId: Int
    let title: String
    let releaseDate: String
    let posterPath: String?
}

struct MovieResponse: Codable {
    let results: [Movies]
}

