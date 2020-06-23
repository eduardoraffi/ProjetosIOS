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
    var movieList : [DetailsModel] = []
    var filterHeaderAux: [Int : String] = [:]
    var moviesResponse: [MoviesResponse.Movie] = []
    
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
        self.moviesResponse.removeAll()

        for object in data.results{
            var genres: String = ""
            for id in object.genre_ids!{
                genres += (self.filterHeaderAux[id] ?? "")
                genres += ", "
            }
            genres.removeLast(2)
            let banner: UIImage
            let backdrop: UIImage
            var backdropPath = object.backdrop_path ?? "/"
            var posterPath = object.poster_path ?? "/"
            
            banner = HttpUtils.getUrlImage(&posterPath)
            backdrop = HttpUtils.getUrlImage(&backdropPath)
            self.moviesResponse.append(object)
            self.movieList.append(DetailsModel(
                id: Int(object.id!),
                movieShowcaseBanner: backdrop,
                movieImage: banner,
                favoriteImage:  CoreDataUtils.checkFavorited(movieTitle: object.title!) ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!,
                rate: String(object.vote_average!),
                title: object.title!,
                genre: genres,
                country: "Não informado",
                description: object.overview!,
                evaluatedBy: "IMDB",
                movieDuration: 000,
                numberOfVotes: object.vote_count!))
        }
            self.initializeTableView()
            self.loadingView.isHidden = true
        }
    }
}
