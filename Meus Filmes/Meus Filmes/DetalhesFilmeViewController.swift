//
//  DetalhesFilmeViewController.swift
//  Meus Filmes
//
//  Created by Eduardo Jeronymo Goulart Raffi on 19/05/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import Foundation
import UIKit

class DetalhesFilmeViewController: UIViewController{
    var filme: Filme!
    @IBOutlet weak var filmeImage: UIImageView!
    @IBOutlet weak var tituloFilme: UILabel!
    @IBOutlet weak var descricaoFilme: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmeImage.image = filme.imagem
        tituloFilme.text = filme.titulo
        descricaoFilme.text = filme.descricao
        let alert = UIAlertController(title: "Fer que pediu", message: "VQV", preferredStyle: .alert)
        let acaoOK = UIAlertAction(title: "Filme", style: .default, handler: nil)
        let imageView = UIImageView(frame: CGRect(x: 10, y: 20, width: 40, height: 40))
        imageView.image = filmeImage.image
       
        alert.view.addSubview(imageView)
        alert.addAction(acaoOK)
        present(alert, animated: true, completion: nil)
    }
    
    
}
