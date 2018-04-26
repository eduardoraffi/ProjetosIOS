//
//  Viagem.swift
//  CursoAluraAulasLayout
//
//  Created by Hst Dev on 25/04/2018.
//  Copyright © 2018 Hst Dev. All rights reserved.
//

import UIKit

class Viagem: NSObject {
    let titulo:String
    let quantidadeDedias:Int
    let preco:String
    let caminhoDaImagem:String
    
    init(titulo:String, quantidadeDeDias:Int,preco:String,caminhoDaImagem:String){
        self.titulo = titulo
        self.quantidadeDedias = quantidadeDeDias
        self.preco = preco
        self.caminhoDaImagem = caminhoDaImagem
    }
}
