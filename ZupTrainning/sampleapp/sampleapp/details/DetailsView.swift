//
//  DetailsView.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 15/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit

class DetailsView:UIView{
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var gradeTextfield: UITextField!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
