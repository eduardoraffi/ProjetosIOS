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
        if(searchMoviesResponse.count == 0){
            self.searchTableView.setEmptyMessage("Qual filme você está procurando O_o?")
        } else{
            self.searchTableView.setEmptyMessage("")
        }
        return searchMoviesResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Utils.instantiateTableViewCell(tableView: searchTableView, indexPath: indexPath, moviesList: searchMoviesResponse)
        
        let gesture = CustomTapRecognizer.init(target: self, action: #selector(favoriteTapped(gesture:)))
        gesture.movieFav = searchMoviesResponse[indexPath.row]
        cell.favoriteIconImageView.addGestureRecognizer(gesture)
        cell.favoriteIconImageView.isUserInteractionEnabled = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowDetails = searchMoviesResponse[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        
        let secondVC = storyboard.instantiateViewController(withIdentifier: "DetailsStoryboard") as? DetailsViewController
        secondVC?.details = rowDetails
        secondVC?.moviesData = searchMoviesResponse
        secondVC?.filterHeaderAux = filterHeaderAux
        self.navigationController?.show(secondVC!, sender: self)
    }
    
    @objc private func favoriteTapped(gesture: CustomTapRecognizer){
        CoreDataUtils.save(movie: gesture.movieFav!)
        searchTableView.reloadData()
    }
}
