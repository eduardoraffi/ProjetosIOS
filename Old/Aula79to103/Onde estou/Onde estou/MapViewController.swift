//
//  ViewController.swift
//  Onde estou
//
//  Created by Eduardo Jeronymo Goulart Raffi on 31/08/17.
//  Copyright © 2017 Eduardo Jeronymo Goulart Raffi. All rights reserved.
//
import Foundation
import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var enderecoLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var velocidadeLabel: UILabel!
   
    
    var gerenciadorDeLocalizacao = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //seta como delegate o delegate da biblioteca MKMAPVIEWDELEGATE
        gerenciadorDeLocalizacao.delegate = self
        //configura a precisao da localização oferecida
        gerenciadorDeLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        //apos colocar no plist, é preciso validar via codigo o requestauthorization
        gerenciadorDeLocalizacao.requestWhenInUseAuthorization()
        //comeca a atualizar localização
        gerenciadorDeLocalizacao.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let localizacaoUsuario = locations.last! 
        let latitude = localizacaoUsuario.coordinate.latitude
        let longitude = localizacaoUsuario.coordinate.longitude
        
        longitudeLabel.text = String(describing: latitude)
        latitudeLabel.text = String(describing: latitude)
        velocidadeLabel.text = String(describing: localizacaoUsuario.speed)
        
        let deltaLatitude: CLLocationDegrees = 0.01
        let deltaLongitude: CLLocationDegrees = 0.01
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let areaExibicao: MKCoordinateSpan = MKCoordinateSpanMake(deltaLatitude,deltaLongitude)
        
        let regiao: MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaExibicao)
        
        mapa.setRegion(regiao, animated: true)
        
        CLGeocoder().reverseGeocodeLocation(localizacaoUsuario) { (detalhesLocal, erro) in
            if erro == nil {
                
                
                if let dadosLocal = detalhesLocal?.first {
                    
                    var throughFare = ""
                    if dadosLocal.thoroughfare != nil {
                        throughFare = dadosLocal.thoroughfare!
                    }//throughfare means avenue
                    
                    var subThroughFare = ""
                    if dadosLocal.subThoroughfare != nil {
                        subThroughFare = dadosLocal.thoroughfare!
                    }
                    
                    var locality = ""
                    if dadosLocal.locality != nil {
                        locality = dadosLocal.locality!
                    }
                    
                    var subLocality = ""
                    if dadosLocal.subLocality != nil {
                        subLocality = dadosLocal.subLocality!
                    }
                    
                    var postalCode = ""
                    if dadosLocal.postalCode != nil {
                        postalCode = dadosLocal.postalCode!
                    }
                    
                    var country = ""
                    if dadosLocal.country != nil {
                        country = dadosLocal.country!
                    }
                    
                    var administrativeArea = ""
                    if dadosLocal.administrativeArea != nil {
                        administrativeArea = dadosLocal.administrativeArea!
                    }
                    
                    var subAdministrativeArea = ""
                    if dadosLocal.subAdministrativeArea != nil {
                        subAdministrativeArea = dadosLocal.subAdministrativeArea!
                    }
                    
                    self.enderecoLabel.text = throughFare + " - "
                                              + subThroughFare + " / "
                                              + locality + " / "
                                              + country
                    
                }
            } else {
                    print(erro)
            }
        }
        
    }

    //Funcao para controlar se o usuario desabilitou ou nao a localizacao no app
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        //status retorna true caso esteja autorizado
        if status == .authorizedWhenInUse {
            //alertaController recebe um Alert contendo titulo e mensagem para o usuario
            let alertaController = UIAlertController(title: "Permissão para acesso a sua localização", message: "Necessario permissao para acesso a sua localização", preferredStyle: .alert)
            //acaoconfiguracoes contem um botao que direciona atraves do handler para a tela de configuracoes (para que o usuario nao tenha que procurar onde ficam as configuraçoes de localização do app
            let acaoConfiguracoes = UIAlertAction(title: "Abrir configurações", style: .default, handler: {
                (alertaConfiguracoes) in
                if let configuracoes = NSURL(string: UIApplicationOpenSettingsURLString) {
                 UIApplication.shared.open(configuracoes as URL)
                    //Closure - Funcao para ser executada exclusivamente no handler.
                    //Se existir a string UIApplicationOpenSettingsURLString ele abre a tela configuracoes como uma url
                }
            })
            let acaoCancelar = UIAlertAction(title: "cancelar", style: .default, handler: nil)
            alertaController.addAction(acaoConfiguracoes)
            alertaController.addAction(acaoCancelar)
        }else {
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

