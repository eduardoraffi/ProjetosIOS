//
//  GenreModel.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 16/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation

struct GenreModel: Codable {
    
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    let genres: [Genre]
}

struct MoviesResponse: Codable {
    
    struct Movie: Codable {
        let popularity: Double?
        let vote_count: Int?
        let poster_path: String?
        let id: Int?
        let adult: Bool?
        let backdrop_path: String?
        let original_language: String?
        let original_title: String?
        let genre_ids: [Int]?
        let title: String?
        let vote_average: Double?
        let overview: String?
        let release_date: String?
    }
    let results : [Movie]
}
