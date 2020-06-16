//
//  LoadingView.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 16/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet weak var cantConnectView: UIView!
    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var tryAgainButton: UIButton!
    
    @IBAction func buttonAction(_ sender: Any) {
        
    }
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
