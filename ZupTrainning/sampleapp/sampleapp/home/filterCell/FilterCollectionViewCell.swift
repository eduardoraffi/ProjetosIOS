//
//  FilterCollectionViewCell.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 10/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var filterBackView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    override var isSelected: Bool {
        didSet{
            updateState()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        filterBackView.layer.borderWidth = 1
        filterBackView.layer.borderColor = UIColor.darkGray.cgColor
        filterBackView.layer.cornerRadius = filterLabel.frame.size.height/3
        updateState()
    }
    
    private func updateState(){
        if isSelected {
            filterLabel.textColor = .white
            filterBackView.backgroundColor = .darkGray
        } else {
            filterLabel.textColor = .lightGray
            filterBackView.backgroundColor = .clear
        }
    }
}
