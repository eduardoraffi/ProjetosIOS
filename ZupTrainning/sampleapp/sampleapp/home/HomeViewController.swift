//
//  HomeViewController.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 10/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController{
    
    @IBOutlet weak var loadingView: LoadingView!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet var mainView: UIView!
    
    let kNibName = "HomeCardViewCell"
    let kCollectionNames = "FilterCollectionViewCell"
    var movieList : [MoviesResponseModel] = []
    var filterHeaderAux: [Int : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFilterBar()
        genresRequest()
    }
    
    @objc private func tryAgainButtonAction(){
        externalRequest(HttpUtils.FILTER_URL)
        externalRequest("\(HttpUtils.GENRE_URL)\(String(describing: filterHeaderAux.first!.key))&")
    }
    
    private func initializeFilterBar(){
        homeCollectionView.register(UINib.init(nibName: kCollectionNames, bundle: nil), forCellWithReuseIdentifier: kCollectionNames)
        homeCollectionView.allowsMultipleSelection = false
        homeCollectionView.reloadData()
    }
    
    private func initializeTableView(){
        homeTableView.register(UINib.init(nibName: kNibName, bundle: nil), forCellReuseIdentifier: kNibName)
        homeTableView.backgroundColor = .clear
        homeTableView.reloadData()
    }
    
    private func genresRequest(){
        loadingView.loadingStatus(true)
        loadingView.isHidden = false
        
        HttpUtils.requestTask(HttpUtils.FILTER_URL) { (genresModel: GenreModel) in
            self.populateGenreList(genresModel)
        }
    }
    
    public func externalRequest(_ requestType: String){
        movieList.removeAll()
        HttpUtils.requestTask(requestType) { (movie: MoviesResponse) in
            self.populateMoviesList(movie)
        }
    }
    
    private func populateGenreList(_ data: GenreModel){
        for genre in data.genres{
            self.filterHeaderAux.updateValue(genre.name, forKey: genre.id)
        }
        DispatchQueue.main.async {
            self.homeCollectionView.reloadData()
        }
        externalRequest("\(HttpUtils.GENRE_URL)\(String(describing: filterHeaderAux.first!.key))&")
    }
    
    private func populateMoviesList(_ data: MoviesResponse) {
        DispatchQueue.main.async {
            self.movieList.removeAll()
            Utils.populateWithMovies(data: data, filterDictionary: &self.filterHeaderAux, moviesArray: &self.movieList)
            self.initializeTableView()
            self.loadingView.isHidden = true
        }
    }
}
