//
//  TarefaViewController.swift
//  Lista de tarefas
//
//  Created by Eduardo Jeronymo Goulart Raffi on 25/05/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import UIKit

class TarefaViewController: UIViewController {

    @IBOutlet weak var tarefaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func adicionarTarefa(_ sender: UIButton) {
        if let tarefa = tarefaTextField.text
        {
            let tarefaUserDefaults = TarefasUserDefaults()
            tarefaUserDefaults.salvarTarefa(tarefa: tarefa)
            tarefaTextField.text = ""
            
        }
        
    }

}
