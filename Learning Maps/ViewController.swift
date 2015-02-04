//
//  ViewController.swift
//  Learning Maps
//
//  Created by Marco F.A. Corzani on 08.01.15.
//  Copyright (c) 2015 Alphaweb. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var manager : CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //Core Location  ( Wo bin ich?)
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        
        
        
        
        
        // 50.120293, 8.672716
        
        var latitude : CLLocationDegrees = 50.120293
        var longitude : CLLocationDegrees = 8.672716
        
        var latDelda : CLLocationDegrees = 0.01
        var lonDelda : CLLocationDegrees = 0.01
        
        var span : MKCoordinateSpan = MKCoordinateSpanMake(latDelda, lonDelda)
        
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)
        
        // Pin setzen
        
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        
        annotation.title = "Emil-Claar-Strasse 9"
        
        annotation.subtitle = "Home of King Corzani"
        
        
        mapView.addAnnotation(annotation)
        

        
        
        //  Geht nicht
        var pinView = MKAnnotationView()
        pinView.image =  UIImage(named:"knob.png")
        println(pinView.image)
        

        // Geht auch nicht
//      Pin Farbe ändern // geht nur red, Purple oder Green
//      var pinView = MKPinAnnotationView()
//      pinView.pinColor = MKPinAnnotationColor.Green
        
        
        
        // Durch langes Drücken, eigenen Pin setzen
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")  //Doppelpunkt, weil die func action Parameter hat!!
        
        uilpgr.minimumPressDuration = 2.0
        
        mapView.addGestureRecognizer(uilpgr)
    }

    func action(gestureRecognizer: UIGestureRecognizer) {
    
        var touchPoint = gestureRecognizer.locationInView(self.mapView)
        
        var newCoordinate: CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        
        var newAnnotation = MKPointAnnotation()
        
        newAnnotation.coordinate = newCoordinate
        
        newAnnotation.title = "Meine eigene Location"
        
        newAnnotation.subtitle = "Ganz neu!!"
        
        mapView.addAnnotation(newAnnotation)
    
    }
    
    
    
    //Core Location  ( Wo bin ich?)
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    //println("locations = \(locations)")
        var userLocation : CLLocation = locations[0] as CLLocation
        
        var latitude : CLLocationDegrees = userLocation.coordinate.latitude
        var longitude : CLLocationDegrees = userLocation.coordinate.longitude
        
        var latDelda : CLLocationDegrees = 0.01
        var lonDelda : CLLocationDegrees = 0.01
        
        var span : MKCoordinateSpan = MKCoordinateSpanMake(latDelda, lonDelda)
        
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)

    
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    
    
    

}

