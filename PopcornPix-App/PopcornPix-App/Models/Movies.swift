//
//  Movie.swift
//  PopcornPix-App
//
//  Created by Kirthi Maharaj on 2024/08/26.
//

import Foundation

struct Movies: Decodable {
    let id: Int
    let title: String
    let release_date: String
    let backdrop_path: String?
    let poster_path: String?
}

struct MovieResponse: Decodable {
    let results: [Movies]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

