//
//  MovieDetails.swift
//  PopcornPix-App
//
//  Created by Kirthi Maharaj on 2024/08/26.
//

import Foundation

struct MovieDetails: Codable {
    let id: Int
       let title: String
       let overview: String
       let releaseDate: String
       let posterPath: String?
       let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
