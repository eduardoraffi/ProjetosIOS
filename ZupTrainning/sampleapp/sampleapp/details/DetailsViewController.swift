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
    @IBOutlet weak var moreOptionsStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let kNibName = "HomeCardViewCell"
    var details: DetailsModel! = nil
    var moviesData: [DetailsModel] = []
    
    override func viewDidLoad() {
        initializeGestures()
        populateView()
        let xib = Bundle.main.loadNibNamed("DetailsView", owner: self, options: nil)?.first as! DetailsView
        
        xib.bannerImageView.image = moviesData[0].movieImage
        xib.gradeTextfield.text = moviesData[0].rate
        xib.titleTextField.text = moviesData[0].title
        xib.favoriteImageView.image = moviesData[0].favoriteImage
        xib.genreTextField.text = moviesData[0].genre
        xib.countryTextField.text = moviesData[0].country
        xib.detailsTextView.text = moviesData[0].description
        let xib2 = Bundle.main.loadNibNamed("DetailsView", owner: self, options: nil)?.first as! DetailsView
        xib2.bannerImageView.image = moviesData[1].movieImage
        xib2.gradeTextfield.text = moviesData[1].rate
        xib2.titleTextField.text = moviesData[1].title
        xib2.favoriteImageView.image = moviesData[1].favoriteImage
        xib2.genreTextField.text = moviesData[1].genre
        xib2.countryTextField.text = moviesData[1].country
        xib2.detailsTextView.text = moviesData[1].description
        
        moreOptionsStackView.addArrangedSubview(xib)
        
        moreOptionsStackView.addArrangedSubview(xib2)
    }
    
    private func initializeGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.backTapped))
        backArrowImageView.addGestureRecognizer(tap)
        backArrowImageView.isUserInteractionEnabled = true
    }
    
    @objc private func backTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func populateView(){
        bannerImageView.image = details.movieShowcaseBanner
        posterImageView.image = details.movieImage
        titleLabel.text = details.title
        genreLabel.text = details.genre
        countrygenreLabel.text = details.country
        ratingTextField.text = details.rate
        ratingAverageLabel.text = details.rate + "/10"
        durationTimeLabel.text = "\(details.movieDuration) min"
        descriptionTextView.text = details.description
        voteNumberLabel.text = "Quantidade de votos: \(String(details.numberOfVotes))"
        moreOptionsLabel.text = "Opções semelhantes:"
    }
}
