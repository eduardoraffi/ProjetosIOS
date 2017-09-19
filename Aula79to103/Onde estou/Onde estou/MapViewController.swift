//
//  ViewController.swift
//  Onde estou
//
//  Created by Eduardo Jeronymo Goulart Raffi on 31/08/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//
import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

