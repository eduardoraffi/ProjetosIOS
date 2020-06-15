//
//  FavoritesViewController.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 11/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit


class FavoritesViewController: UIViewController{
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    let kNibName = "HomeCardViewCell"
    var mockInfo : [DetailsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTableView()
    }
    
    func initializeTableView(){
        favoritesTableView.register(UINib.init(nibName: kNibName, bundle: nil), forCellReuseIdentifier: kNibName)
        favoritesTableView.backgroundColor = .clear
        
        // MARK: Mocking data
        mockInfo.append(DetailsModel(movieShowcaseBanner: UIImage(named: "lionking")!, movieImage: UIImage(named: "lionking")!, favoriteImage: UIImage(systemName: "heart.fill")!, rate: "9.0", title: "O Rei Leão (2019)", genre: "Aventura, Família", country: "United States of America", description: "Filme do gatinho pistola que vinga o pai morto pelo tio mais pistola ainda", evaluatedBy: "IMDB", movieDuration: 118, numberOfVotes: 3500))
            
        favoritesTableView.reloadData()
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: kNibName, for: indexPath) as! HomeCardViewCell
        
        cell.selectionStyle = .none
        
        cell.movieBannerImageView.image = mockInfo[indexPath.row].movieImage
        cell.movieRatingTextField.text = mockInfo[indexPath.row].rate
        
        cell.movieTitleTextField.text = mockInfo[indexPath.row].title
        cell.favoriteIconImageView.image = mockInfo[indexPath.row].favoriteImage
        cell.movieGenreTextField.text = mockInfo[indexPath.row].genre
        cell.movieCountryTextField.text = mockInfo[indexPath.row].country
        cell.movieDescriptionTextView.text = mockInfo[indexPath.row].description
        
        return cell
    }
    
    
}
