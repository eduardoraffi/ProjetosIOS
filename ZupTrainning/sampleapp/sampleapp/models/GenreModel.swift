//
//  GenreModel.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 16/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation

class GenreModel {
    let id: String
    let name: String
    
    init(_ id: String, _ name:String) {
        self.id = id
        self.name = name
    }
    
    func toString() -> String{
        return """
        Id: \(id)
        Genre: \(name)
        """
    }
}
