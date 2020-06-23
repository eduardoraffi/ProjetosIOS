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
        if filterHeaderAux.count == 0 {
            genresRequest(searchText)
        } else {
            externalRequest("\(HttpUtils.SEARCH_URL)\(searchText)&")
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
            
            banner = self.getUrlImage(&posterPath)
            backdrop = self.getUrlImage(&backdropPath)
            
            self.searchResults.append(DetailsModel(
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
        }
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
    
    private func genresRequest(_ searchText: String){
        HttpUtils.requestTask(HttpUtils.FILTER_URL) { (genresModel: GenreModel) in
            self.populateGenreList(genresModel)
            DispatchQueue.main.async {
                self.externalRequest("\(HttpUtils.SEARCH_URL)\(searchText)&")
            }
            
        }
    }
    
    public func externalRequest(_ requestType: String){
        HttpUtils.requestTask(requestType) { (movie: MoviesResponse) in
            self.getApiItems(movie)
            DispatchQueue.main.async {
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchResults.count == 0){
            self.searchTableView.setEmptyMessage("Qual filme você está procurando O_o?")
        } else{
            self.searchTableView.setEmptyMessage("")
        }
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: kNibName, for: indexPath) as! HomeCardViewCell
         
         cell.selectionStyle = .none
                
         cell.movieBannerImageView.image = searchResults[indexPath.row].movieImage
         cell.movieRatingTextField.text = searchResults[indexPath.row].rate
         cell.movieTitleTextField.text = searchResults[indexPath.row].title
         cell.favoriteIconImageView.image = searchResults[indexPath.row].favoriteImage
         cell.movieGenreTextField.text = searchResults[indexPath.row].genre
         cell.movieCountryTextField.text = searchResults[indexPath.row].country
         cell.movieDescriptionTextView.text = searchResults[indexPath.row].description
        
         return cell
    }
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 24)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
