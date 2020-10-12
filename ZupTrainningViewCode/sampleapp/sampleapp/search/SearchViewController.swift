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
    var searchMoviesResponse : [MoviesResponseModel] = []
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
        searchMoviesResponse.removeAll()
        Utils.populateWithMovies(data: data, filterDictionary: &self.filterHeaderAux, moviesArray: &self.searchMoviesResponse)
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
