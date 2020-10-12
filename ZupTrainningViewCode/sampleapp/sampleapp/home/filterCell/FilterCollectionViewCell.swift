//
//  FilterCollectionViewCell.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 10/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    var filterBackView:UIView = {
        let view = UIView(frame: .zero)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.cornerRadius = 20
        return view
    }()
    var filterLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    override var isSelected: Bool {
        didSet{
            updateState()
        }
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
