//
//  ViewController.swift
//  AluraModule2
//
//  Created by Hst Dev on 18/04/2018.
//  Copyright © 2018 Hst Dev. All rights reserved.
//


import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var enviarBotao: UIButton!
    @IBOutlet weak var textFieldComida: UITextField!
    @IBOutlet weak var textFieldFelicidade: UITextField!
    
    var list:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickEnviar(_ sender: Any) {
        if let campo1 = textFieldComida.text, let campo2 = textFieldFelicidade.text{
            list.append(campo1)
            list.append(campo2)
        }
        textFieldFelicidade.text = nil
        textFieldComida.text = nil
            
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueTela"{
            if let destinationVC = segue.destination as? TableViewController {
                destinationVC.viewRef.list = list
            }
        }
    }
}

