//
//  GenreModel.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 16/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit

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

class MoviesResponseModel {
    
    let popularity: Double
    let vote_count: Int
    let poster_path: String
    let id: Int
    let adult: Bool
    let backdrop_path: String
    let original_language: String
    let original_title: String
    let genre_ids: [Int]
    let title: String
    let vote_average: Double
    let overview: String
    let release_date: String
    let posterImage: UIImage
    let bannerImage: UIImage
    let genresToString: String
    let country: String = "Não informado"
    let evaluatedBy: String = "IMDB"
    let movieDuration: Int = 000
    
    required init(popularity: Double,
                  vote_count: Int,
                  poster_path: String,
                  id: Int,
                  adult: Bool,
                  backdrop_path: String,
                  original_language: String,
                  original_title: String,
                  genre_ids: [Int],
                  title: String,
                  vote_average: Double,
                  overview: String,
                  release_date: String,
                  posterImage: UIImage,
                  bannerImage: UIImage,
                  genresToString: String)
    {
        self.popularity = popularity
        self.vote_count = vote_count
        self.poster_path = poster_path
        self.id = id
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.original_language = original_language
        self.original_title = original_title
        self.genre_ids = genre_ids
        self.title = title
        self.vote_average = vote_average
        self.overview = overview
        self.release_date = release_date
        self.posterImage = posterImage
        self.bannerImage = bannerImage
        self.genresToString = genresToString
    }
}
