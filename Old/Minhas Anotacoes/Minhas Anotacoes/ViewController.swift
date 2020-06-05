//
//  ViewController.swift
//  Minhas Anotacoes
//
//  Created by Eduardo Jeronymo Goulart Raffi on 19/05/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaults.standard.setValue("Azul", forKey: "Cor de fundo")
        //let texto = UserDefaults.standard.object(forKey: "Cor de fundo")
        //print(texto)
        //var array : [String] = ["lasanha","pizza","torta"]
        //UserDefaults.standard.set(array,forKey: "comidas")
        let comidasUsuario = UserDefaults.standard.object(forKey: "comidas")
        print(comidasUsuario)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

