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
    var mockInfo : [MoviesResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mockInfo.removeAll()
        retrieveDataFromCore()
        initializeTableView()
        super.viewDidAppear(animated)
    }
    
    func initializeTableView(){
        favoritesTableView.register(UINib.init(nibName: kNibName, bundle: nil), forCellReuseIdentifier: kNibName)
        favoritesTableView.backgroundColor = .clear
        favoritesTableView.separatorStyle = .none
        favoritesTableView.reloadData()
    }
    
    func retrieveDataFromCore(){
        mockInfo.removeAll()
        let coreData: [Favorites] = CoreDataUtils.recoverData()
        for object in coreData {
            let banner: UIImage
            let backdrop: UIImage
            var backdropPath = object.backdrop_path ?? "/"
            var posterPath = object.poster_path ?? "/"
            
            banner = HttpUtils.getUrlImage(&posterPath)
            backdrop = HttpUtils.getUrlImage(&backdropPath)
            
            mockInfo.append(MoviesResponseModel(
                popularity: object.popularity ,
                vote_count: Int(object.vote_count) ,
                poster_path: object.poster_path ?? "/",
                id: Int(object.id),
                adult: object.adult,
                backdrop_path: object.backdrop_path ?? "/",
                original_language: object.original_language ?? "Information is missing",
                original_title: object.original_title ?? "Information is missing",
                genre_ids: NSKeyedUnarchiver.unarchiveObject(with: object.genre_ids!) as! [Int],
                title: object.title ?? "Information is missing",
                vote_average: object.vote_average,
                overview: object.overview ?? "Information is missing",
                release_date: object.release_date ?? "Information is missing",
                posterImage: backdrop ,
                bannerImage: banner,
                genresToString: object.genreToString ?? "Não informado"))
        }
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
        let cell = Utils.instantiateTableViewCell(tableView: favoritesTableView , indexPath: indexPath, moviesList: mockInfo)
        
        let gesture = CustomTapRecognizer.init(target: self, action: #selector(favoriteTapped(gesture:)))
        gesture.movieFav = mockInfo[indexPath.row]
        cell.favoriteIconImageView.addGestureRecognizer(gesture)
        cell.favoriteIconImageView.isUserInteractionEnabled = true
        
        return cell
    }
    
    @objc private func favoriteTapped(gesture: CustomTapRecognizer){
        CoreDataUtils.save(movie: gesture.movieFav!)
        retrieveDataFromCore()
        favoritesTableView.reloadData()
    }
}
