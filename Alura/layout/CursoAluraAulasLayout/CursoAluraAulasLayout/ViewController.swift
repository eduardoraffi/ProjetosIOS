//
//  ViewController.swift
//  CursoAluraAulasLayout
//
//  Created by Hst Dev on 24/04/2018.
//  Copyright © 2018 Hst Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var labelCidadeDestino: UILabel!
    @IBOutlet weak var labelPreco: UILabel!
    @IBOutlet weak var labelDias: UILabel!
    @IBOutlet weak var imagemLugar: UIImageView!
    @IBOutlet weak var tableViewTelaInicial: UITableView!
    
    let teste:Array<String> = ["Rio de janeiro", "São Paulo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewTelaInicial.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAluraViagens", for: indexPath)
        return cell
   }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teste.count
   }

    
    
    
}

