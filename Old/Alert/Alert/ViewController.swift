//
//  ViewController.swift
//  Alert
//
//  Created by Eduardo Jeronymo Goulart Raffi on 17/05/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func botaoAlerta(_ sender: UIButton) {
        //criandoalerta
        
        let alertaController = UIAlertController(title: "Alerta", message: "teste", preferredStyle: .actionSheet)
        let acaoConfirmar = UIAlertAction(title: "Confirmar", style: .default, handler: nil)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        alertaController.addAction(acaoConfirmar)
        alertaController.addAction(acaoCancelar)
        
        present(alertaController, animated: true, completion: nil)
            
            
            
        
    }


}

