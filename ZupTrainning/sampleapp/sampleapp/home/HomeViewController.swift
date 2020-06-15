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
    
    let kNibName = "HomeCardViewCell"
    let kCollectionNames = "FilterCollectionViewCell"
    var mockInfo : [DetailsModel] = []
    var mockHeader: [String:Bool] = ["Ação":false, "Drama":false, "Aventura":false, "Suspense":false, "Terror":false, "Comédia":false, "Romance":false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFilterBar()
        initializeTableView()
    }
    
    func initializeFilterBar(){
        homeCollectionView.register(UINib.init(nibName: kCollectionNames, bundle: nil), forCellWithReuseIdentifier: kCollectionNames)

        homeCollectionView.allowsMultipleSelection = true
    }
    
    func initializeTableView(){
        homeTableView.register(UINib.init(nibName: kNibName, bundle: nil), forCellReuseIdentifier: kNibName)
        homeTableView.backgroundColor = .clear
        
        // MARK: Mocking data
        mockInfo.append(DetailsModel(movieShowcaseBanner: UIImage(named: "lionking")!, movieImage: UIImage(named: "lionking")!, favoriteImage: UIImage(systemName: "heart.fill")!, rate: "9.0", title: "O Rei Leão (2019)", genre: "Aventura, Família", country: "United States of America", description: "Filme do gatinho pistola que vinga o pai morto pelo tio mais pistola ainda", evaluatedBy: "IMDB", movieDuration: 118, numberOfVotes: 3500))
        mockInfo.append(DetailsModel(movieShowcaseBanner: UIImage(named: "lionking")!, movieImage: UIImage(named: "lionking")!, favoriteImage: UIImage(systemName: "heart.fill")!, rate: "9.0", title: "O Gol (2019)", genre: "Aventura, Família", country: "United States of America", description: "Filme do gatinho pistola que vinga o pai morto pelo tio mais pistola ainda", evaluatedBy: "IMDB", movieDuration: 118, numberOfVotes: 3500))
        mockInfo.append(DetailsModel(movieShowcaseBanner: UIImage(named: "lionking")!, movieImage: UIImage(named: "lionking")!, favoriteImage: UIImage(systemName: "heart.fill")!, rate: "9.0", title: "Puma: A origem (2019)", genre: "Aventura, Família", country: "United States of America", description: "Filme do gatinho pistola que vinga o pai morto pelo tio mais pistola ainda", evaluatedBy: "IMDB", movieDuration: 118, numberOfVotes: 3500))
        mockInfo.append(DetailsModel(movieShowcaseBanner: UIImage(named: "lionking")!, movieImage: UIImage(named: "lionking")!, favoriteImage: UIImage(systemName: "heart.fill")!, rate: "9.0", title: "Fuscas Brasil (2019)", genre: "Aventura, Família", country: "United States of America", description: "Filme do gatinho pistola que vinga o pai morto pelo tio mais pistola ainda", evaluatedBy: "IMDB", movieDuration: 118, numberOfVotes: 3500))
        
        
        homeTableView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockHeader.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: kCollectionNames, for: indexPath) as! FilterCollectionViewCell
        cell.filterLabel.text = Array(mockHeader.keys)[indexPath.row]
        cell.filterBackView.layer.cornerRadius = cell.filterLabel.frame.size.height/3
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let value = !Array(mockHeader.values)[indexPath.row]
        mockHeader[Array(mockHeader.keys)[indexPath.row]] = value
        // MARK: Atualiza query db
        //        collectionView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockInfo.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: kNibName, for: indexPath) as! HomeCardViewCell
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowDetails = mockInfo[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        
        let secondVC = storyboard.instantiateViewController(withIdentifier: "DetailsStoryboard") as? DetailsViewController
        secondVC?.details = rowDetails
        secondVC?.moviesData = mockInfo
        self.present(secondVC!, animated:true, completion:nil)
    }
}
