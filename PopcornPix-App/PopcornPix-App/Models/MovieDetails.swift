//
//  MovieDetails.swift
//  PopcornPix-App
//
//  Created by Kirthi Maharaj on 2024/08/26.
//

import Foundation

struct MovieDetails: Decodable {
    let id: Int
    let original_title: String
    let overview: String
    let release_date: String
    let original_language: String
    let backdrop_path: String?
    let poster_path: String?
    let runtime: Int
    let genres: [Genre]
    
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
