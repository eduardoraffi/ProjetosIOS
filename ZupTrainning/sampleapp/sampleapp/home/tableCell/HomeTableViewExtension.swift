//
//  HomeTableViewExtension.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 18/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: kNibName, for: indexPath) as! HomeCardViewCell
        
        cell.selectionStyle = .none
        let movie = moviesResponse.filter({($0.title?.contains(movieList[indexPath.row].title))!})

        cell.movieBannerImageView.image = movieList[indexPath.row].movieImage
        cell.movieRatingTextField.text = movieList[indexPath.row].rate
        
        cell.movieTitleTextField.text = movieList[indexPath.row].title
        cell.favoriteIconImageView.image = CoreDataUtils.checkFavorited(movieTitle: (movie.first?.title)!) ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
        cell.movieGenreTextField.text = movieList[indexPath.row].genre
        cell.movieCountryTextField.text = movieList[indexPath.row].country
        cell.movieDescriptionTextView.text = movieList[indexPath.row].description
        
        let gesture = CustomTapRecognizer.init(target: self, action: #selector(favoriteTapped(gesture:)))
        gesture.movieFav = movie.first!
        cell.favoriteIconImageView.addGestureRecognizer(gesture)
        cell.favoriteIconImageView.isUserInteractionEnabled = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowDetails = movieList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        
        let secondVC = storyboard.instantiateViewController(withIdentifier: "DetailsStoryboard") as? DetailsViewController
        secondVC?.details = rowDetails
        secondVC?.moviesData = movieList
        self.navigationController?.show(secondVC!, sender: self)
    }
    
    @objc private func favoriteTapped(gesture: CustomTapRecognizer){
        CoreDataUtils.save(movie: gesture.movieFav!)
        homeTableView.reloadData()
    }
}

class CustomTapRecognizer: UITapGestureRecognizer {
    var movieFav: MoviesResponse.Movie?
}

