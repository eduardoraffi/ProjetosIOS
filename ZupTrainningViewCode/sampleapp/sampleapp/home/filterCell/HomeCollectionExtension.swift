//
//  FilterCollectionExtension.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 18/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterHeaderAux.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = FilterCollectionViewCell()
        cell.filterLabel.text = Array(filterHeaderAux.values)[indexPath.row]
        cell.filterBackView.layer.cornerRadius = cell.filterLabel.frame.size.height/3
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
        
        var path = "discover/movie?with_genres="
        for (id, name) in filterHeaderAux{
            if(cell.filterLabel.text == name){
                path.append("\(String(id))&")
            }
        }
        loadingView.isHidden = false
        self.externalRequest(path)
        self.homeTableView.reloadData()
    }
}
