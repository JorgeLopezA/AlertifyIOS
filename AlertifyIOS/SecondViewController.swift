//
//  SecondViewController.swift
//  AlertifyIOS
//
//  Created by Jorge Lopez on 5/7/19.
//  Copyright © 2019 Jorge Lopez. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let gps = CLLocationManager()
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configurarMapa()
    }
    
    func configurarMapa(){
        map.delegate = self
        gps.delegate = self
        gps.desiredAccuracy = kCLLocationAccuracyBest
        gps.requestWhenInUseAuthorization()
        // Zoom inicial
        let centro = CLLocationCoordinate2DMake(19.5953, -99.2276)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: centro, span: span)
        map.region = region
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        if status == .authorizedWhenInUse{
            gps.startUpdatingLocation()
            gps.startUpdatingHeading()
        } else if status == .denied{
            print("Permiso denegado")
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        map.setCenter(userLocation.coordinate, animated: true)
        
        //Pin sobre el mapa
        let pin = MKPointAnnotation()
        pin.coordinate = userLocation.coordinate
        pin.title = "Intento de Robo"
        pin.subtitle = "Tec CEM"
        map.addAnnotation(pin)
    }

}

