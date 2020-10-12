//
//  LoadingView.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 16/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

@IBDesignable
class LoadingView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cantConnectView: UIView!
    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    private var isLoading : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
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
