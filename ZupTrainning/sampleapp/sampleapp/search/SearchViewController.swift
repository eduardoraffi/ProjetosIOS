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
    var mockInfo : [DetailsModel] = []
    var searchResults : [DetailsModel] = []
    
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
        
        // MARK: Mocking data
        mockInfo.append(DetailsModel(movieShowcaseBanner: UIImage(named: "lionking")!, movieImage: UIImage(named: "lionking")!, favoriteImage: UIImage(systemName: "heart.fill")!, rate: "9.0", title: "O Rei Leão (2019)", genre: "Aventura, Família", country: "United States of America", description: "Filme do gatinho pistola que vinga o pai morto pelo tio mais pistola ainda", evaluatedBy: "IMDB", movieDuration: 118, numberOfVotes: 3500))
        
        mockInfo.append(DetailsModel(movieShowcaseBanner: UIImage(named: "lionking")!, movieImage: UIImage(named: "lionking")!, favoriteImage: UIImage(systemName: "heart.fill")!, rate: "10.0", title: "Primeira guerra mundial", genre: "Aventura, Violência", country: "United States of America", description: "Pew pew pew, pow pow pow, tatatatatata ---- nhooooooooooooooon, booooom, tatatatatata ahhhhhhhhhhh fire in the hole", evaluatedBy: "IMDB", movieDuration: 130, numberOfVotes: 100))
        
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
        searchResults = mockInfo.filter({$0.title.prefix(searchText.count) == searchText})
        if searchText.count == 0 {
            searchResults.removeAll()
        }
        searchTableView.reloadData()
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
