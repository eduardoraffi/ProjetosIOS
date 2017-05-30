//
//  ViewController.swift
//  Trabalhando com mapas
//
//  Created by Eduardo Jeronymo Goulart Raffi on 30/05/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    var gerenciadorDeLocal = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        gerenciadorDeLocal.delegate = self
        gerenciadorDeLocal.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorDeLocal.requestWhenInUseAuthorization()
        gerenciadorDeLocal.startUpdatingLocation()
        
        
        /*
        
                
        
        mapa.setRegion(regiao , animated: true)
        
        let anotacao = MKPointAnnotation()
        anotacao.coordinate = localizacao
        anotacao.title = "puccamp"
        anotacao.subtitle = "assalto a boleto armado"
        
        mapa.addAnnotation(anotacao)*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let localizacaoUsuario: CLLocation = locations.last!
        
        let latitude: CLLocationDegrees = localizacaoUsuario.coordinate.latitude
        let longitude: CLLocationDegrees = localizacaoUsuario.coordinate.longitude
        
        let deltaLatitude:CLLocationDegrees = 0.01 //delta eh o zoom no mapa, quanto menor mais perto
        let deltaLongitude:CLLocationDegrees = 0.01
        
        let areaVisaulizacao: MKCoordinateSpan = MKCoordinateSpanMake(deltaLatitude,deltaLongitude)
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude,longitude)
        
        let regiao: MKCoordinateRegion = MKCoordinateRegionMake(localizacao,areaVisaulizacao)
    }


}

