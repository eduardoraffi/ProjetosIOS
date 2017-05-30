//
//  ViewController.swift
//  Minhas anotacoes app
//
//  Created by Eduardo Jeronymo Goulart Raffi on 19/05/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var campoDeDigitacao: UITextView!
    let minhaAnotacaoChave = "minhaAnotacao"
    override func viewDidLoad() {
        super.viewDidLoad()
        //recuperar infos
        let textoRecuperado = self.recuperarDadosAnotacao()
        campoDeDigitacao.text = textoRecuperado
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSalvar(_ sender: UIButton) {
        if let texto = campoDeDigitacao.text{
            self.salvarDadosAnotacao(texto: texto)
        }
    }
    
    func salvarDadosAnotacao(texto : String){
        UserDefaults.standard.set(texto, forKey: minhaAnotacaoChave)
        esconderTeclado()
    }
    
    func recuperarDadosAnotacao() ->String
    {
        let textoRecuperado = UserDefaults.standard.object(forKey: minhaAnotacaoChave)
        if textoRecuperado != nil{
         return textoRecuperado as! String
        }else{
            return ""
        }
    }
    
    func esconderTeclado(){
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.esconderTeclado()
    }
    
    override var prefersStatusBarHidden: Bool
        {
            return true
    }
    
}

