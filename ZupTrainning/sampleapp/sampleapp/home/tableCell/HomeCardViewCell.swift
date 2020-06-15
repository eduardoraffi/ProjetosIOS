//
//  HomeCardViewCell.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 10/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

class HomeCardViewCell: UITableViewCell {

        @IBOutlet weak var homeContentView: UIView!
        @IBOutlet weak var movieBannerImageView: UIImageView!
        @IBOutlet weak var movieRatingTextField: UITextField!
        @IBOutlet weak var favoriteIconImageView: UIImageView!
        @IBOutlet weak var movieTitleTextField: UITextField!
        @IBOutlet weak var movieGenreTextField: UITextField!
        @IBOutlet weak var movieCountryTextField: UITextField!
        @IBOutlet weak var movieDescriptionTextView: UITextView!
        
        override func awakeFromNib() {
            super.awakeFromNib()
        }
}
