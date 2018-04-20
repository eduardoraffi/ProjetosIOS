//
//  ViewController.swift
//  xibTeste
//
//  Created by Hst Dev on 20/04/2018.
//  Copyright © 2018 Hst Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var testView: TestView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testView.titulo.text = "Alo alo alo"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

