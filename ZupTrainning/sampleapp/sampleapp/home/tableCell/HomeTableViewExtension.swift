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
        
        cell.movieBannerImageView.image = movieList[indexPath.row].movieImage
        cell.movieRatingTextField.text = movieList[indexPath.row].rate
        
        cell.movieTitleTextField.text = movieList[indexPath.row].title
        cell.favoriteIconImageView.image = movieList[indexPath.row].favoriteImage
        cell.movieGenreTextField.text = movieList[indexPath.row].genre
        cell.movieCountryTextField.text = movieList[indexPath.row].country
        cell.movieDescriptionTextView.text = movieList[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowDetails = movieList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        
        let secondVC = storyboard.instantiateViewController(withIdentifier: "DetailsStoryboard") as? DetailsViewController
        secondVC?.details = rowDetails
        secondVC?.moviesData = movieList
        self.navigationController?.show(secondVC!, sender: self)
        
        //        present(secondVC!, animated:true, completion:nil)
    }
}

