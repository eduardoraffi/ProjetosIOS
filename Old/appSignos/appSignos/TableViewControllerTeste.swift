//
//  TableViewControllerTeste.swift
//  appSignos
//
//  Created by Eduardo Jeronymo Goulart Raffi on 17/05/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import Foundation
import UIKit

class TableViewControllerTeste : UITableViewController{
    var listaSignos: [String] = []
    var significadoSignos : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        listaSignos.append("Aries")
        listaSignos.append("Touro")
        listaSignos.append("Gemeos")
        listaSignos.append("Cancer")
        listaSignos.append("Leao")
        listaSignos.append("Virgem")
        listaSignos.append("Libra")
        listaSignos.append("Escorpiao")
        listaSignos.append("Sagitario")
        listaSignos.append("Capricornio")
        listaSignos.append("Aquario")
        listaSignos.append("Peixes")
        
        significadoSignos.append("batata")
        significadoSignos.append("cenoura")
        significadoSignos.append("tuberculo")
        significadoSignos.append("ouro")
        significadoSignos.append("prata")
        significadoSignos.append("bronze")
        significadoSignos.append("brasil")
        significadoSignos.append("alemanha")
        significadoSignos.append("argentina")
        significadoSignos.append("carrossel")
        significadoSignos.append("maisa")
        significadoSignos.append("boliche")
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaSignos.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let nomeCelula = "celulaSignos"
        let celula = tableView.dequeueReusableCell(withIdentifier: nomeCelula, for: indexPath)
        celula.textLabel?.text = listaSignos[indexPath.row]        
        
        return celula
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let alert = UIAlertController(title: listaSignos[indexPath.row], message: significadoSignos[indexPath.row], preferredStyle: .alert)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertBotaoOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        
        alert.addAction(alertBotaoOk)
        
        present(alert, animated: true, completion: nil)
        
        
    }
}
