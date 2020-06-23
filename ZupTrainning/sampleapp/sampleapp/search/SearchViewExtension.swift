//
//  SearchViewExtension.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 23/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchResults.count == 0){
            self.searchTableView.setEmptyMessage("Qual filme você está procurando O_o?")
        } else{
            self.searchTableView.setEmptyMessage("")
        }
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: kNibName, for: indexPath) as! HomeCardViewCell
        
        cell.selectionStyle = .none
        let movie = searchMoviesResponse.filter({($0.title?.contains(searchResults[indexPath.row].title))!})
        
        cell.movieBannerImageView.image = searchResults[indexPath.row].movieImage
        cell.movieRatingTextField.text = searchResults[indexPath.row].rate
        cell.movieTitleTextField.text = searchResults[indexPath.row].title
        cell.favoriteIconImageView.image = CoreDataUtils.checkFavorited(movieTitle: (movie.first?.title)!) ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
        cell.movieGenreTextField.text = searchResults[indexPath.row].genre
        cell.movieCountryTextField.text = searchResults[indexPath.row].country
        cell.movieDescriptionTextView.text = searchResults[indexPath.row].description
        
        let gesture = CustomTapRecognizer.init(target: self, action: #selector(favoriteTapped(gesture:)))
        gesture.movieFav = movie.first!
        cell.favoriteIconImageView.addGestureRecognizer(gesture)
        cell.favoriteIconImageView.isUserInteractionEnabled = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowDetails = searchResults[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        
        let secondVC = storyboard.instantiateViewController(withIdentifier: "DetailsStoryboard") as? DetailsViewController
        secondVC?.details = rowDetails
        secondVC?.moviesData = searchResults
        self.navigationController?.show(secondVC!, sender: self)
    }
    
    @objc private func favoriteTapped(gesture: CustomTapRecognizer){
        CoreDataUtils.save(movie: gesture.movieFav!)
        searchTableView.reloadData()
    }
}

