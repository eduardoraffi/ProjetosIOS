//
//  MapViewController.swift
//  Minhas Viagens
//
//  Created by Eduardo Jeronymo Goulart Raffi on 01/08/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import Foundation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var map: MKMapView!
    var localizationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateLocalizationManager()
    }
    
    func configurateLocalizationManager() {
        
        localizationManager.delegate = self
        localizationManager.desiredAccuracy = kCLLocationAccuracyBest
        localizationManager.requestWhenInUseAuthorization()
        localizationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse{
            
            let alertController = UIAlertController(title: "Localization permission", message: "Permission needed to access your localization! Please authorize", preferredStyle: .alert)
            let configActions = UIAlertAction(title: "Open Configs", style: .default, handler: {
                (alertaConfiguracoes) in
                if let config = NSURL(string: UIApplicationOpenSettingsURLString){
                    UIApplication.shared.open(config as URL)
                }
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alertController.addAction(configActions)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true,completion: nil)
            
        }
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
