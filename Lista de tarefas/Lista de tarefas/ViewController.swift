//
//  ViewController.swift
//  Lista de tarefas
//
//  Created by Eduardo Jeronymo Goulart Raffi on 22/05/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var tarefas: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        atualizaLista()
        
    }
 
    override func viewDidAppear(_ animated: Bool) {
        //sempre que a tela for chamada ele carrega aqui
        atualizaLista()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tarefas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celulaTableView = "celulaReuso"
        let celula = tableView.dequeueReusableCell(withIdentifier: celulaTableView, for: indexPath)
        celula.textLabel?.text = tarefas[indexPath.row]
        
        return celula
    }
    
    func atualizaLista()
    {
        let tarefaUserDefaults = TarefasUserDefaults()
        tarefas = tarefaUserDefaults.listarTarefas()
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            let tarefaUserDefault = TarefasUserDefaults()
            tarefaUserDefault.removerTarefa(indice: indexPath.row)
            atualizaLista()
            tableView.reloadData()
        }
        
    }
    

}

