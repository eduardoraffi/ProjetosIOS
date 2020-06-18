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
        return filterHeader.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: kCollectionNames, for: indexPath) as! FilterCollectionViewCell
        cell.filterLabel.text = Array(filterHeaderAux.values)[indexPath.row]
        cell.filterBackView.layer.cornerRadius = cell.filterLabel.frame.size.height/3
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
        for (key , value) in filterHeader{
            if Array(key.keys)[0].contains(cell.filterLabel.text!) && value{
                return
            }
        }
        
        for (key , _) in filterHeader {
            filterHeader[key] = false
            if Array(key.keys)[0].contains(cell.filterLabel.text!){
                filterHeader[key] = true
                break
            }
        }
        
        var path = "discover/movie?with_genres="
        for (key,value) in filterHeader{
            //            print((String(Array(key.keys)[0])) + ":" + (String(Array(key.values)[0])))
            if(value){
                path.append((String(Array(key.values)[0]) + ","))
            }
        }
        path.removeLast()
        path.append("&")
        self.externalRequest(path)
        self.homeTableView.reloadData()
    }
}
