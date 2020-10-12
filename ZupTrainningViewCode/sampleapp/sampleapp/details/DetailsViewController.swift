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
    @IBOutlet weak var topView: UIView!
    
    let kNibName = "HomeCardViewCell"
    var details: MoviesResponseModel?
    var moviesData: [MoviesResponseModel]?
    var filterHeaderAux: [Int : String]?
    var similarMoviesResponse: [MoviesResponseModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        topView.layer.cornerRadius = 15
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.layer.masksToBounds = true
        topView.clipsToBounds = true
        similarMoviesRequest()
    }
    
    override func viewDidLoad() {
        initializeGestures()
        populateView()
    }
    
    private func populateView(){
        bannerImageView.image = details?.bannerImage
        favoriteImageView.image = CoreDataUtils.checkFavorited(movieTitle: details!.title) ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
        posterImageView.image = details?.posterImage
        titleLabel.text = details?.title
        genreLabel.text = details?.genresToString
        countrygenreLabel.text = details?.country
        ratingTextField.text = String(details!.vote_average)
        ratingAverageLabel.text = "\(String(details!.vote_average))/10"
        durationTimeLabel.text = "\(details!.movieDuration) min"
        descriptionTextView.text = details?.overview
        voteNumberLabel.text = "Quantidade de votos: \(String(details!.vote_count))"
        moreOptionsLabel.text = "Opções semelhantes:"
    }
    
    private func similarMoviesRequest(){
        HttpUtils.requestTask("\(HttpUtils.SIMILAR_URL1)\(details!.id)\(HttpUtils.SIMILAR_URL2)") { (response: MoviesResponse) in
            self.populateMoviesList(response)
        }
    }
    
    private func populateMoviesList(_ data: MoviesResponse) {
        DispatchQueue.main.async {
            Utils.populateWithMovies(data: data, filterDictionary: &(self.filterHeaderAux)!, moviesArray: &self.similarMoviesResponse)
            self.populateSimilar()
        }
    }
    
    private func populateSimilar(){
        moreOptionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for object in moviesData![0..<5] {
            if !(object.title == details!.title) {
                let xib = Bundle.main.loadNibNamed("DetailsView", owner: self, options: nil)?.first as! DetailsView
                xib.bannerImageView.image = object.bannerImage
                xib.gradeTextfield.text = String(object.vote_average)
                xib.titleTextField.text = object.title
                xib.favoriteImageView.image = CoreDataUtils.checkFavorited(movieTitle: object.title) ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
                xib.genreTextField.text = object.genresToString
                xib.countryTextField.text = object.country
                xib.detailsTextView.text = object.overview
                
                let gesture = CustomTapRecognizer.init(target: self, action: #selector(favoriteTapped(gesture:)))
                gesture.movieFav = object
                xib.favoriteImageView.addGestureRecognizer(gesture)
                xib.favoriteImageView.isUserInteractionEnabled = true
                
                moreOptionsStackView.addArrangedSubview(xib)
            }
        }
    }
    
    private func initializeGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.backTapped))
        backArrowImageView.addGestureRecognizer(tap)
        backArrowImageView.isUserInteractionEnabled = true
        let gesture = CustomTapRecognizer.init(target: self, action: #selector(favoriteTapped(gesture:)))
        favoriteImageView.addGestureRecognizer(gesture)
    }
    
    @objc private func backTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func favoriteTapped(gesture: CustomTapRecognizer){
        CoreDataUtils.save(movie: gesture.movieFav!)
        self.populateSimilar()
    }
}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
