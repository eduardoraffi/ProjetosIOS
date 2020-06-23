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
    var details: DetailsModel! = nil
    var moviesData: [DetailsModel] = []
    var filterHeaderAux: [Int : String] = [:]
    var moviesResponse: [MoviesResponse.Movie] = []
    
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
    private func genresRequest(){
        HttpUtils.requestTask(HttpUtils.FILTER_URL) { (genresModel: GenreModel) in
            self.populateGenreList(genresModel)
        }
    }
    
    private func populateGenreList(_ data: GenreModel){
        for genre in data.genres{
            self.filterHeaderAux.updateValue(genre.name, forKey: genre.id)
        }
        similarMoviesRequest()
    }
    
    private func similarMoviesRequest(){
        HttpUtils.requestTask("\(HttpUtils.SIMILAR_URL1)\(details.id)\(HttpUtils.SIMILAR_URL2)") { (response: MoviesResponse) in
            self.populateMoviesList(response)
        }
    }
    
    private func populateMoviesList(_ data: MoviesResponse) {
        DispatchQueue.main.async {

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
            self.moviesData.append(DetailsModel(
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
            self.populateSimilar()
        }
    }
    
    private func initializeGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.backTapped))
        backArrowImageView.addGestureRecognizer(tap)
        backArrowImageView.isUserInteractionEnabled = true
    }
    
    @objc private func backTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func populateSimilar(){
        for object in moviesData[0..<5] {
            if !(object.title == details.title) {
                let xib = Bundle.main.loadNibNamed("DetailsView", owner: self, options: nil)?.first as! DetailsView
                xib.bannerImageView.image = object.movieImage
                xib.gradeTextfield.text = object.rate
                xib.titleTextField.text = object.title
                xib.favoriteImageView.image = object.favoriteImage
                xib.genreTextField.text = object.genre
                xib.countryTextField.text = object.country
                xib.detailsTextView.text = object.description
                
                moreOptionsStackView.addArrangedSubview(xib)
            }
        }
    }
    
    private func populateView(){
        bannerImageView.image = details.movieShowcaseBanner
        favoriteImageView.image = details.favoriteImage
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
    
    @objc private func favoriteTapped(gesture: CustomTapRecognizer){
        CoreDataUtils.save(movie: gesture.movieFav!)
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
