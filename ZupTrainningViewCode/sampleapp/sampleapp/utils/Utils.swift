//
//  Utils.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 24/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit

protocol ViewCodable {
    func buildView()
    func setupConstraints()
    func setupAdditionalConfig()
    func setupView()
}

extension ViewCodable {
    func setupView(){
        buildView()
        setupConstraints()
        setupAdditionalConfig()
    }
}

class Utils {
    public static let HOME_NIB_NAME = "HomeCardViewCell"
    
    public static func instantiateTableViewCell(tableView: UITableView, indexPath: IndexPath, moviesList: [MoviesResponseModel]) -> DetailsView{
        let cell = DetailsView()
        
        cell.bannerImageView.image = moviesList[indexPath.row].bannerImage
        cell.gradeTextfield.text = String(moviesList[indexPath.row].vote_average)
        
        cell.titleTextField.text = moviesList[indexPath.row].title
        cell.favoriteImageView.image = CoreDataUtils.checkFavorited(movieTitle: (moviesList[indexPath.row].title)) ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
        cell.genreTextField.text = moviesList[indexPath.row].genresToString
        cell.countryTextField.text = moviesList[indexPath.row].country
        cell.detailsTextView.text = moviesList[indexPath.row].overview
        
        return cell
    }
    
    public static func populateWithMovies(data: MoviesResponse, filterDictionary: inout [Int: String], moviesArray: inout [MoviesResponseModel]) {
        for object in data.results{
            var genres: String = ""
            for id in object.genre_ids!{
                genres += (filterDictionary[id] ?? "")
                genres += ", "
            }
            if genres.count > 2 {
                genres.removeLast(2)
            } else {
                genres = "Missing information"
            }
            let banner: UIImage
            let backdrop: UIImage
            var backdropPath = object.backdrop_path ?? "/"
            var posterPath = object.poster_path ?? "/"
            
            banner = HttpUtils.getUrlImage(&posterPath)
            backdrop = HttpUtils.getUrlImage(&backdropPath)
            moviesArray.append(
                MoviesResponseModel(
                    popularity: object.popularity ?? 0,
                    vote_count: object.vote_count ?? 0,
                    poster_path: object.poster_path ?? "/",
                    id: object.id ?? 0,
                    adult: object.adult ?? false,
                    backdrop_path: object.backdrop_path ?? "/",
                    original_language: object.original_language ?? "Information is missing",
                    original_title: object.original_title ?? "Information is missing",
                    genre_ids: object.genre_ids ?? [],
                    title: object.title ?? "Information is missing",
                    vote_average: object.vote_average ?? 0,
                    overview: object.overview ?? "Information is missing",
                    release_date: object.release_date ?? "Information is missing",
                    posterImage: backdrop,
                    bannerImage: banner,
                    genresToString: genres))
        }
    }
    
}

class CustomTapRecognizer: UITapGestureRecognizer {
    var movieFav: MoviesResponseModel?
}
