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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mockInfo.removeAll()
        let coreData: [Favorites] = CoreDataUtils.recoverData()
            for object in coreData {
                mockInfo.append(DetailsModel(
                    id: Int(object.id),
                    movieShowcaseBanner: HttpUtils.getUrlImage(&object.backdrop_path!),
                    movieImage: HttpUtils.getUrlImage(&object.poster_path!),
                    favoriteImage: UIImage(systemName: "heart.fill")!,
                    rate: String(object.vote_average),
                    title: object.title!,
                    genre: "Ajustar depois",
                    country: "Nao informado",
                    description: object.overview!,
                    evaluatedBy: "IMDB",
                    movieDuration: 000,
                    numberOfVotes: Int(object.vote_count)))
            }
        
        initializeTableView()
        super.viewDidAppear(animated)
    }
    
    func initializeTableView(){
        favoritesTableView.register(UINib.init(nibName: kNibName, bundle: nil), forCellReuseIdentifier: kNibName)
        favoritesTableView.backgroundColor = .clear
        favoritesTableView.separatorStyle = .none
        favoritesTableView.reloadData()
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(mockInfo.count == 0){
            self.favoritesTableView.setEmptyMessage("Você ainda não favoritou nenhum filme.")
        } else{
            self.favoritesTableView.setEmptyMessage("")
        }
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
