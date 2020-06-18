//
//  LoadingView.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 16/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet var mainView: LoadingView!
    @IBOutlet weak var cantConnectView: UIView!
    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    private var isLoading : Bool = false
    
//    override class func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        UINib.init(nibName: "LoadingView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
    }
    
    func loadingStatus(_ loading: Bool){
        isLoading = loading
        if isLoading {
            self.loadingImage.isHidden = false
            self.cantConnectView.isHidden = true
        } else {
            self.loadingImage.isHidden = true
            self.cantConnectView.isHidden = false
        }
    }
}
