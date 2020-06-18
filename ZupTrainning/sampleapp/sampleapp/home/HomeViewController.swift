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
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet var mainView: UIView!
    
    let kNibName = "HomeCardViewCell"
    let kCollectionNames = "FilterCollectionViewCell"
    var movieList : [DetailsModel] = []
    var filterHeader: [[String : Int]:Bool] = [:]
    var filterHeaderAux: [Int : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLoadingView()
        genresRequest()
    }

    private func initializeLoadingView(){
//        loadingView.tryAgainButton.addTarget(self, action: #selector(self.tryAgainButtonAction), for: .touchDown)
//        loadingView.isHidden = false
    }

    @objc private func tryAgainButtonAction(){
//        loadingView.loadingStatus(true)
        externalRequest(HttpUtils.FILTER_URL)
        externalRequest("\(HttpUtils.GENRE_URL)\(String(describing: filterHeaderAux.first!.key))&")
        
    }
    
    private func getUrlImage( _ path: inout String) -> UIImage{
        if !path.contains("/"){
            path = "/"+path
        }
        do{
            let imageUrl = URL(string: "http://image.tmdb.org/t/p/w780/\(path)")
            let data = try Data(contentsOf: imageUrl!)
            return UIImage(data: data)!
        } catch{
            return UIImage(named: "lionking")!
        }
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
            self.filterHeader.updateValue(false, forKey: [genre.name: genre.id])
            self.filterHeaderAux.updateValue(genre.name, forKey: genre.id)
        }
        self.filterHeader[self.filterHeader.first?.key ?? ["none":0]] = true
        DispatchQueue.main.async {
            self.initializeFilterBar()
        }
        externalRequest("\(HttpUtils.GENRE_URL)\(String(describing: filterHeaderAux.first!.key))&")
    }
    
    private func populateMoviesList(_ data: MoviesResponse) {
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
            
            banner = self.getUrlImage(&posterPath)
            backdrop = self.getUrlImage(&backdropPath)
            
            self.movieList.append(DetailsModel(
                movieShowcaseBanner: backdrop,
                movieImage: banner,
                favoriteImage: UIImage(systemName: "heart")!,
                rate: String(object.vote_average!),
                title: object.title!,
                genre: genres,
                country: "Não informado",
                description: object.overview!,
                evaluatedBy: "IMDB",
                movieDuration: 000,
                numberOfVotes: object.vote_count!))
            
            DispatchQueue.main.async {
                self.initializeTableView()
            }
        }
    }
}
