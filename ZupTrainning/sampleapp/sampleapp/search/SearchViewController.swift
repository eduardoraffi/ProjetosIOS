//
//  SearchViewController.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 11/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController{
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let kNibName = "HomeCardViewCell"
    var searchResults : [DetailsModel] = []
    var searchMoviesResponse : [MoviesResponse.Movie] = []
    var filterHeaderAux: [Int : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTableView()
        initializeSearchBar()
    }
    
    func initializeSearchBar(){
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
    }
    
    func initializeTableView(){
        searchTableView.register(UINib.init(nibName: kNibName, bundle: nil), forCellReuseIdentifier: kNibName)
        searchTableView.backgroundColor = .clear
        
        searchTableView.reloadData()
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField,
            let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            
            if searchText.count == 0 {
                glassIconView.tintColor = .secondaryLabel
            } else {
                glassIconView.tintColor = .white
            }
        }
        if filterHeaderAux.count == 0  {
            genresRequest(searchText)
        } else {
            moviesRequest("\(HttpUtils.SEARCH_URL)\(searchText)&")
        }
    }
    
    func getApiItems(_ data: MoviesResponse){
        searchResults.removeAll()
        for object in data.results{
            var genres: String = ""
            for id in object.genre_ids!{
                genres += (self.filterHeaderAux[id] ?? "")
                genres += ", "
            }
            if genres.count > 2 {
                genres.removeLast(2)
            } else {
                genres = "Sem informação"
            }
            let banner: UIImage
            let backdrop: UIImage
            var backdropPath = object.backdrop_path ?? "/"
            var posterPath = object.poster_path ?? "/"
            
            banner = HttpUtils.getUrlImage(&posterPath)
            backdrop = HttpUtils.getUrlImage(&backdropPath)
            self.searchMoviesResponse.append(object)
            self.searchResults.append(DetailsModel(
                id: Int(object.id!),
                movieShowcaseBanner: backdrop,
                movieImage: banner,
                favoriteImage: CoreDataUtils.checkFavorited(movieTitle: object.title!) ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!,
                rate: String(object.vote_average!),
                title: object.title!,
                genre: genres,
                country: "Não informado",
                description: object.overview!,
                evaluatedBy: "IMDB",
                movieDuration: 000,
                numberOfVotes: object.vote_count!))
        }
    }
    
    private func genresRequest(_ searchText: String){
        HttpUtils.requestTask(HttpUtils.FILTER_URL) { (genresModel: GenreModel) in
            self.populateGenreList(genresModel)
            DispatchQueue.main.async {
                self.moviesRequest("\(HttpUtils.SEARCH_URL)\(searchText)&")
            }
            
        }
    }
    
    public func moviesRequest(_ requestType: String){
        HttpUtils.requestTask(requestType) { (movie: MoviesResponse) in
            DispatchQueue.main.async {
                self.getApiItems(movie)
                self.searchTableView.reloadData()
            }
        }
    }
    
    private func populateGenreList(_ data: GenreModel){
        for genre in data.genres{
            self.filterHeaderAux.updateValue(genre.name, forKey: genre.id)
        }
    }
    
}
