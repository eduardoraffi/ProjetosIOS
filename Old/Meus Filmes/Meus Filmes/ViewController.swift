//
//  ViewController.swift
//  Meus Filmes
//
//  Created by Eduardo Jeronymo Goulart Raffi on 19/05/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var filmes: [Filme] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        var filme : Filme
        filme = Filme(titulo: "filme1", descricao: "descricao 1", imagem: #imageLiteral(resourceName: "filme1"))
            filmes.append(filme)
        
        filme = Filme(titulo: "filme2", descricao: "descricao 2", imagem: #imageLiteral(resourceName: "filme2"))
        filmes.append(filme)
        
        filme = Filme(titulo: "filme3", descricao: "descricao 3", imagem: #imageLiteral(resourceName: "filme3"))
        filmes.append(filme)
        
        filme = Filme(titulo: "filme4", descricao: "descricao 4", imagem: #imageLiteral(resourceName: "filme4"))
        filmes.append(filme)
        
        filme = Filme(titulo: "filme5", descricao: "descricao 5", imagem: #imageLiteral(resourceName: "filme5"))
        filmes.append(filme)
        
        filme = Filme(titulo: "filme6", descricao: "descricao 6", imagem: #imageLiteral(resourceName: "filme6"))
        filmes.append(filme)
        
        filme = Filme(titulo: "filme7", descricao: "descricao 7", imagem: #imageLiteral(resourceName: "filme7"))
        filmes.append(filme)
        
        filme = Filme(titulo: "filme8", descricao: "descricao 8", imagem: #imageLiteral(resourceName: "filme8"))
        filmes.append(filme)
        
        filme = Filme(titulo: "filme9", descricao: "descricao 9", imagem: #imageLiteral(resourceName: "filme9"))
        filmes.append(filme)
        
        filme = Filme(titulo: "filme10", descricao: "descricao 10", imagem: #imageLiteral(resourceName: "filme10"))
        filmes.append(filme)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nameCelula = "celulaFilme"
        let filme = filmes[indexPath.row]
        let celula = tableView.dequeueReusableCell(withIdentifier: nameCelula, for: indexPath) as! FilmeCelula
        celula.imageCelula.image = filme.imagem
        celula.tituloFilme.text = filme.titulo
        celula.descricaoFilme.text = filme.descricao
        
        celula.imageCelula.clipsToBounds = true
        celula.imageCelula.layer.cornerRadius = 10
        /*celula.imageView?.image = filme.imagem
        celula.textLabel?.text = filme.titulo
        */
        return celula
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheFilme"{
        
            if let indexPath = tableView.indexPathForSelectedRow
            {
                let filmeSelecionado = self.filmes[indexPath.row]
                let viewControllerDestino = segue.destination as! DetalhesFilmeViewController
                viewControllerDestino.filme = filmeSelecionado
                
            }
        
        }
    }

}

