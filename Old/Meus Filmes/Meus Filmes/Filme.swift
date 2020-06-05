//
//  Filme.swift
//  Meus Filmes
//
//  Created by Eduardo Jeronymo Goulart Raffi on 19/05/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import Foundation
import UIKit

class Filme{
    
    var titulo: String!
    var descricao: String!
    var imagem: UIImage!
    
    
    init(titulo: String, descricao: String, imagem: UIImage)
    {
        self.titulo = titulo
        self.descricao = descricao
        self.imagem = imagem
    }
    
}
