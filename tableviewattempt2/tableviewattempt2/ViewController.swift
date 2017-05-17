//
//  ViewController.swift
//  tableviewattempt2
//
//  Created by Eduardo Jeronymo Goulart Raffi on 17/05/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var vetor: [String] = ["abacate","cenoura","chuchu"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vetor.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifierCell = "indentityCell"
        let celula = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        celula.textLabel?.text = vetor[indexPath.row]
        return celula
    }


}

