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
        let cell = Utils.instantiateTableViewCell(tableView: homeTableView, indexPath: indexPath, moviesList: movieList)
        
        let gesture = CustomTapRecognizer.init(target: self, action: #selector(favoriteTapped(gesture:)))
        gesture.movieFav = movieList[indexPath.row]
        cell.favoriteImageView.addGestureRecognizer(gesture)
        cell.favoriteImageView.isUserInteractionEnabled = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        
        let secondVC = storyboard.instantiateViewController(withIdentifier: "DetailsStoryboard") as? DetailsViewController
        secondVC?.details = movieList[indexPath.row]
        secondVC?.moviesData = movieList
        secondVC?.filterHeaderAux = filterHeaderAux
        self.navigationController?.show(secondVC!, sender: self)
    }
    
    @objc private func favoriteTapped(gesture: CustomTapRecognizer){
        CoreDataUtils.save(movie: gesture.movieFav!)
        homeTableView.reloadData()
    }
}
