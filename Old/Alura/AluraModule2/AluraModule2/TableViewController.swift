//
//  ViewController.swift
//  AluraModule2
//
//  Created by Hst Dev on 18/04/2018.
//  Copyright © 2018 Hst Dev. All rights reserved.
//

import UIKit
import Foundation

class TableViewController: UITableViewController {

    let viewRef = ViewController()
    
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
        return viewRef.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellReuse"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewRef.list[indexPath.row]
        return cell
    }
   
    //override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    //}

}

