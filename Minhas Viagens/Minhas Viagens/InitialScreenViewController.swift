//
//  ViewController.swift
//  Minhas Viagens
//
//  Created by Eduardo Jeronymo Goulart Raffi on 01/08/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import UIKit


class InitialScreenViewController: UITableViewController {

    var locationsSaved: [String] = ["Apple","United Kingdom","Africa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsSaved.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viagem = locationsSaved[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocalizationCell", for: indexPath)
        cell.textLabel?.text = viagem
        return cell
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


}

