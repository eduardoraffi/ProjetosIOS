//
//  ViewController.swift
//  MapasEGeolocalizacao
//
//  Created by Eduardo Jeronymo Goulart Raffi on 30/08/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//
// MARK: para usar mapas utilizar da classe mapviewdelegate
import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // MARK: Variavel que inicializa CLLocationManager serve para: definir a precisao da localizacao entre muitas outras coisas como autorizacao e etc
    @IBOutlet weak var mapa: MKMapView!
    let gerenciadorDeLocal = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        gerenciador()
        /*
         
         let latitude: CLLocationDegrees = -22.816034
        let longitude: CLLocationDegrees = -47.043612
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let deltaLatitude: CLLocationDegrees = 0.01
        let deltaLongitude: CLLocationDegrees = 0.01

        // MARK: -CoordinateSpan define o zoom do mapa, quanto mais proximo de 0, mais proximo fica a visualizacao
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpanMake(deltaLatitude, deltaLongitude)
        
        // MARK: -para definir uma localizacao precisa de latitude, longitude e o zoom desejado para latidude e longitude (span)
        // MARK: -para regiao MKCoordinateRegion utilizar o Make (MKCoordinateRegionMake) e passar paramentros conforme solicitado
        // MARK: -valores como: latitude, longitude, deltaLatitude e deltaLongitude sao do tipo CLLocationDegrees
        // MARK: -localizacao, o MKCoordinateSpan exige que seja uma coordinate2D (center location) portanto
        let regiao: MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaVisualizacao)
        
        // MARK: -nao esquecer de fazer setRegion, senao nao aparece no mapa
        mapa.setRegion(regiao, animated: true)
        
        // MARK: -para definir um pin location, usa-se MKPointAnnotation
        // MARK: -passa-se a coordenada (lat,long), titulo e subtitulo (opcional)
        let anotacao = MKPointAnnotation()
        anotacao.coordinate = localizacao
        anotacao.title = "CI&T"
        anotacao.subtitle = "Work place"
        mapa.addAnnotation(anotacao)
         
         */
    }
    // MARK: metodo utilizado para pegar posicao atual do usuario
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //locations.last pega a ultima posicao do vetor locations [cllocation]
            if let localizacaoUsuario: CLLocation = locations.last {
                let latitude: CLLocationDegrees = localizacaoUsuario.coordinate.latitude
                let longitude: CLLocationDegrees = localizacaoUsuario.coordinate.longitude
            
                let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                let deltaLatitude: CLLocationDegrees = 0.01
                let deltaLongitude: CLLocationDegrees = 0.01
            
                let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpanMake(deltaLatitude, deltaLongitude)
                let regiao: MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaVisualizacao)
            
                mapa.setRegion(regiao, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -Permissoes : - No menu do aplicativo, tem a opcao link binary with libraries, adiciona-se coreLocation.framework
    // - Configurar PLIST para autorizacoes do usuario e recursos necessarios(ex: gps, location-services e etc)
        private func gerenciador() {
            
        // MARK: -avisa que o CLLocationManager esta delegando a classe
        gerenciadorDeLocal.delegate = self
        gerenciadorDeLocal.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorDeLocal.requestWhenInUseAuthorization()
        gerenciadorDeLocal.startUpdatingLocation()
        
    }

}

