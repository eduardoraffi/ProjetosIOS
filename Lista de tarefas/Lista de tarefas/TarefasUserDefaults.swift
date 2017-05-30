//
//  TarefasUserDefaults.swift
//  Lista de tarefas
//
//  Created by Eduardo Jeronymo Goulart Raffi on 25/05/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import UIKit

class TarefasUserDefaults
{
    let chaveListaRecebe="listaTarefa"
    var tarefas:[String] = []
    
    func salvarTarefa(tarefa: String){
        
        tarefas = listarTarefas()
        
        tarefas.append(tarefa)
        
        UserDefaults.standard.set(tarefas, forKey: chaveListaRecebe)
        
        
    }
    
    func listarTarefas() -> Array<String>
    {
        let dados = UserDefaults.standard.object(forKey: chaveListaRecebe)
        
        if dados != nil {
            
            return dados as! Array
            
        }else{
                return []
        }
        
        
        
    }
    
    func removerTarefa(indice : Int)
    {
        
        tarefas = listarTarefas()
        
        tarefas.remove(at: indice)
         UserDefaults.standard.set(tarefas, forKey: chaveListaRecebe)
    }
    
    
}
