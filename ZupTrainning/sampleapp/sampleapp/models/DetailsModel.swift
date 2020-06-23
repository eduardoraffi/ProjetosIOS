//
//  DetailsModel.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 11/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit

class DetailsModel {
    
    let id: Int
    let movieShowcaseBanner: UIImage
    let movieImage: UIImage
    let title : String
    let favoriteImage: UIImage
    let genre : String
    let country : String
    let evaluatedBy: String
    let rate : String
    let movieDuration: Int
    let numberOfVotes: Int
    let description : String
    
    required init(id: Int,movieShowcaseBanner:UIImage, movieImage:UIImage, favoriteImage:UIImage, rate:String, title:String, genre:String, country:String, description:String, evaluatedBy:String, movieDuration: Int, numberOfVotes: Int) {
        
        self.id = id
        self.movieShowcaseBanner = movieShowcaseBanner
        self.movieImage = movieImage
        self.title = title
        self.favoriteImage = favoriteImage
        self.genre = genre
        self.country = country
        self.evaluatedBy = evaluatedBy
        self.rate = rate
        self.movieDuration = movieDuration
        self.numberOfVotes = numberOfVotes
        self.description = description
    }
    
    func toString() -> String{
        return """
        Title: \(String(describing: title))
        Genre: \(String(describing: genre))
        Country: \(String(describing: country))
        EvaluatedBy: \(String(describing: evaluatedBy))
        Movie Duration: \(String(describing: movieDuration))
        Number of votes: \(String(describing: numberOfVotes))
        Description: \(String(describing: description))
        """
    }
}
