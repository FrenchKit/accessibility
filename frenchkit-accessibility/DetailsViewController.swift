//
//  DetailsViewController.swift
//  frenchkit-accessibility
//
//  Created by amath on 13/09/16.
//  Copyright © 2016 amath. All rights reserved.
//

import Foundation
import MapKit

class DetailsViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    let initialLocation = CLLocation(latitude: 48.8574089, longitude: 2.38664370)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        centerMapOnLocation(initialLocation)
        mapView.addAnnotation(Place(title: "RestaurantIOS", locationName: "Restaurant", coordinate: CLLocationCoordinate2DMake(48.8574089, 2.38664370), imageName: "restaurant"))
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}