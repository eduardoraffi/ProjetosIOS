//
//  ViewController.swift
//  CursoAluraAulasLayout
//
//  Created by Hst Dev on 24/04/2018.
//  Copyright © 2018 Hst Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
   
    @IBOutlet weak var tableViewTelaInicial: UITableView!
    
    let listaViagens:Array<Viagem> = ViagemDAO().retornaTodasAsViagens()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewTelaInicial.delegate = self
        self.tableViewTelaInicial.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAluraViagens", for: indexPath) as! TableViewCell
        let viagemAtual = listaViagens[indexPath.row]
        cell.labelTitulo.text = viagemAtual.titulo
    
    cell.imagemDestino.image = UIImage(named: viagemAtual.caminhoDaImagem)
        cell.labelDias.text = "\(viagemAtual.quantidadeDedias) Dias"
        cell.labelPreco.text = viagemAtual.preco
        return cell
   }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaViagens.count
   }

    
    
    
}

