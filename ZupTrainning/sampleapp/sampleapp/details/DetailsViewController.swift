//
//  DetailsViewController.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 11/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var backArrowImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var countrygenreLabel: UILabel!
    @IBOutlet weak var evaluatedByTextField: UITextField!
    @IBOutlet weak var ratingAverageLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var voteNumberLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var moreOptionsLabel: UILabel!
    @IBOutlet weak var moreOptionsTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let kNibName = "HomeCardViewCell"
    var details: DetailsModel! = nil
    var moviesData: [DetailsModel] = []
    
    override func viewDidLoad() {
        bannerImageView.image = details.movieImage
        posterImageView.image = details.movieImage
        titleLabel.text = details.title
        countrygenreLabel.text = details.country
        ratingTextField.text = details.rate
        ratingAverageLabel.text = details.rate + "/10"
        durationTimeLabel.text = "\(details.movieDuration) min"
        descriptionTextView.text = details.description + "DHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFABDHAEIUDHAUEDKJAEJNDIUAEHNDIUJAEIUDJAEUIDJUIAEJDIUAEJDIUAEHDIUAEFIUAEHFIUAEFIUANEIUFAB"
        moreOptionsLabel.text = "Opções semelhantes:"
        moreOptionsTableView.register(UINib.init(nibName: kNibName, bundle: nil), forCellReuseIdentifier: kNibName)
//        self.moreOptionsTableView.isScrollEnabled = false
//        //no need to write following if checked in storyboard
//        self.scrollView.bounces = false
//        self.moreOptionsTableView.bounces = true
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == self.scrollView {
//            moreOptionsTableView.isScrollEnabled = (self.scrollView.contentOffset.y >= 200)
//        }
//
//        if scrollView == self.moreOptionsTableView {
//            self.moreOptionsTableView.isScrollEnabled = (moreOptionsTableView.contentOffset.y > 0)
//        }
//    }
    
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesData.count == 0{
            self.moreOptionsTableView.setEmptyMessage("Nenhum filme do mesmo gênero encontrado")
        } else{
            self.moreOptionsTableView.setEmptyMessage("")
        }
        return moviesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moreOptionsTableView.dequeueReusableCell(withIdentifier: kNibName, for: indexPath) as! HomeCardViewCell
        
        cell.selectionStyle = .none
        
        cell.movieBannerImageView.image = moviesData[indexPath.row].movieImage
        cell.movieRatingTextField.text = moviesData[indexPath.row].rate
        
        cell.movieTitleTextField.text = moviesData[indexPath.row].title
        cell.favoriteIconImageView.image = moviesData[indexPath.row].favoriteImage
        cell.movieGenreTextField.text = moviesData[indexPath.row].genre
        cell.movieCountryTextField.text = moviesData[indexPath.row].country
        cell.movieDescriptionTextView.text = moviesData[indexPath.row].description
        
        return cell
    }
    
    
}
